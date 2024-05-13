extends State
class_name EnemyMoveState

@export var idle_state: State
var direction: float


func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta

	if move_component._detected_player_right():
		direction = 1
	elif move_component._detected_player_left():
		direction = -1
	elif move_component._detect_fall():
		return idle_state

	var movement = direction * move_speed
	
	if movement == 0:
		return idle_state
	
	if (!move_component._detected_player_right()
		and !move_component._detected_player_left()):
			return idle_state

	animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	return null
