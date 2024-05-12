extends State
class_name FallState

@export var idle_state: State
@export var move_state: State
@export var jump_state: State

@export var wall_friction: float = 0
@export var wall_jump_time: float = 0.5
var wall_jump_timer: float = 0.0

func enter() -> void:
	super()
	wall_jump_timer = wall_jump_time

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement = get_movement_input() * move_speed
	
	if movement != 0:
		animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_wall_only():
		if get_jump():
			jump_state.enter()
		else:
			parent.velocity.y = min(parent.velocity.y, wall_friction)

	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null
