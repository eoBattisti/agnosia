extends MoveState
class_name CounterDashState

@export var move_state: State
@export var time_dashing: float = 1

var dash_duration_timer = 0.0
var direction = 0.0

func enter() -> void:
	super()
	dash_duration_timer = time_dashing
	
	if animations.flip_h:
		direction = 1
	else:
		direction = -1

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	dash_duration_timer -= delta
	if dash_duration_timer <= 0.0:
		if super.get_movement_input() != 0.0:
			return move_state
		return idle_state
	if super.get_movement_input() == 0:
		return idle_state
	return super(delta)

func get_movement_input() -> float:
	return direction

func get_jump() -> bool:
	return false
