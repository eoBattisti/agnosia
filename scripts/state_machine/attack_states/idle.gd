extends State
class_name AttackIdleState

@export var attacking_state: State

func enter() -> void:
	super()
	

func process_input(event: InputEvent) -> State:
	if (Input.is_action_just_pressed("attack")
		and parent.is_on_floor()
		and not parent.movement_state_machine.current_state is RestState
	):
		return attacking_state
	return null
	
func process_frame(delta: float) -> State:
	if parent.velocity.x < 0:
		animations.flip_h = true
	elif parent.velocity.x > 0:
		animations.flip_h = false

	return null
