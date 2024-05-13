extends State
class_name EnemyIdleState

@export var move_state: State
@export var wander_state: State
var time_to_wander = 2.0


func enter() -> void:
	super()
	time_to_wander = 2.0
	parent.velocity.x = 0

func process_input(event: InputEvent) -> State:
	if (move_component._detected_player_right()
		or move_component._detected_player_left()):
		return move_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()

	return null

func process_frame(delta: float) -> State:
	
	time_to_wander -= delta
	if time_to_wander <= 0:
		return wander_state
	return null
