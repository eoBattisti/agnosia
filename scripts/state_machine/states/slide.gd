extends State
class_name SlideState

@export var idle_state: State
@export var move_state: State
@export var jump_state: State
@export var fall_state: State

@export var wall_friction: float = 0
@export var wall_jump_time: float = 0.25

var can_jump = true
var wall_jump_timer: float

func enter() -> void:
	super()
	wall_jump_timer = wall_jump_time

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement = get_movement_input() * move_speed
	
	if movement != 0:
		if movement < 0:
			animations.flip_h = false
		elif  movement > 0:
			animations.flip_h = true

	parent.velocity.x = movement
	parent.move_and_slide()

	if get_jump() and can_jump:
		can_jump = false
		animations.flip_h = movement < 0
		return jump_state
	else:
		parent.velocity.y = min(parent.velocity.y, wall_friction)

	animations.play(animation_name)


	if !parent.is_on_floor() and !parent.is_on_wall():
		return fall_state

	if parent.is_on_floor():
		return idle_state
	return null

func process_frame(delta: float) -> State:
	
	if parent.velocity.x < 0:
		animations.flip_h = false
	elif parent.velocity.x > 0:
		animations.flip_h = true

	wall_jump_timer -= delta
	if wall_jump_timer <= 0.0:
		can_jump = true
		wall_jump_timer = wall_jump_time

	return null
