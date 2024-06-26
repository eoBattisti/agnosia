extends State
class_name JumpState

@export var fall_state: State
@export var idle_state: State
@export var move_state: State
@export var jump_state: State
@export var slide_state: State

@export var jump_force: float = 900.0

func enter() -> void:
	super()
	parent.velocity.y = -jump_force

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	
	if parent.is_on_wall_only():
		return slide_state

	if parent.velocity.y > 0:
		return fall_state

	var movement = get_movement_input() * move_speed

	if movement != 0:
		animations.flip_h = movement < 0
	
	move_toward(parent.velocity.x, 0, 300)

	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	
	return null
