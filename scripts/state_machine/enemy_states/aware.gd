extends State
class_name EnemyAwareState

@export var idle_state: State


func enter() -> void:
	super()
	parent.velocity.x = 0

func process_input(event: InputEvent) -> State:
	if (!move_component._detected_player_right()
		and !move_component._detected_player_left()):
			return idle_state

	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()

	return null

func process_frame(delta: float) -> State:
	if move_component._detected_player_right():
		animations.flip_h = true
	elif move_component._detected_player_left():
		animations.flip_h = false
	return null
