extends State
class_name FallState

@export var idle_state: State
@export var move_state: State
@export var jump_state: State

@export var wall_friction: float = 0
@export var wall_jump_time: float = 0.5
@onready var coyote_timer = $"../CoyoteTimer"
@onready var jump_buffer = $"../JumpBuffer"

var can_jump = true
var wall_jump_timer: float

func enter() -> void:
	super()
	coyote_timer.start()
	wall_jump_timer = wall_jump_time

func process_input(event: InputEvent) -> State:
	
	if !coyote_timer.is_stopped() and get_jump():
		jump_state.enter()
	else:
		jump_buffer.start()
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement = get_movement_input() * move_speed
	
	if movement != 0:
		animations.flip_h = movement < 0

	parent.velocity.x = movement
	parent.move_and_slide()

	if parent.is_on_wall_only():
		if get_jump() and can_jump:
			can_jump = false
			jump_state.enter()
		else:
			parent.velocity.y = min(parent.velocity.y, wall_friction)

	if parent.is_on_floor() and !jump_buffer.is_stopped():
		jump_buffer.stop()
		jump_state.enter()

	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null

func process_frame(delta: float) -> State:

	wall_jump_timer -= delta
	if wall_jump_timer <= 0.0:
		can_jump = true
		wall_jump_timer = wall_jump_time

	return null
