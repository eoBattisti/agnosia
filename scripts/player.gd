extends CharacterBody2D

const SPEED = 130.0
const DASH_SPEED = 400.0
const COUNTER_DASH_SPEED = 800.0
const JUMP_VELOCITY = -350
const WALL_PUSHBACK = 250
const WALL_SLIDE_GRAVITY = 50

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var dash_timer = $DashTimer
@onready var jump_timer = $JumpTimer
@onready var animated_sprite = $AnimatedSprite2D

var max_health = 5
var hurt = false

var can_dash = true
var is_dashing = false

var can_jump = true
var is_jumping = false

var is_wall_sliding = false

func _process(delta):
	
	if hurt:
		animated_sprite.play("hurt")
		hurt = false

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration: -1, 0 or 1	
	var direction = Input.get_axis("move_left", "move_right")

	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		# Standing still
		if direction == 0:
			animated_sprite.play("idle")
		else:
			# Moving
			animated_sprite.play("run")
	else:
		# Jumping or falling
		animated_sprite.play("jump")

	# Apply the movement to the player
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle dashing
	if Input.is_action_just_pressed("dash") and can_dash:
		velocity.x += direction * DASH_SPEED
		can_dash = false
		is_dashing = true
		dash_timer.start()
	if Input.is_action_just_pressed("counter_dash") and can_dash:
		velocity.x -= direction * COUNTER_DASH_SPEED
		can_dash = false
		is_dashing = true
		dash_timer.start()

	move_and_slide()
	handle_jump(delta)
	handle_wall_slide(delta)

func handle_jump(delta):

	if !is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and can_jump:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			is_jumping = true
		elif is_on_wall() and Input.is_action_pressed("move_right") and can_jump:
			can_jump = false
			is_jumping = true
			jump_timer.start()
			velocity.y = JUMP_VELOCITY
			velocity.x = -WALL_PUSHBACK
		elif is_on_wall() and Input.is_action_pressed("move_left") and can_jump:
			can_jump = false
			is_jumping = true
			jump_timer.start()
			velocity.y = JUMP_VELOCITY
			velocity.x = WALL_PUSHBACK

func handle_wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false

	if is_wall_sliding:
		velocity.y += (WALL_SLIDE_GRAVITY * delta)
		velocity.y = min(velocity.y, WALL_SLIDE_GRAVITY)


func handle_damage(damage):
	max_health -= damage
	hurt = true
	if max_health <= 0:
		get_tree().reload_current_scene()


func _on_dash_timer_timeout():
	can_dash = true
	is_dashing = false

func _on_jump_timer_timeout():
	is_jumping = false
	can_jump = true
