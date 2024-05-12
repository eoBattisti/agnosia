extends State
class_name AttackAttackingState

@export var charging_state: State

var is_complete: bool = false

func enter() -> void:
	is_complete = false
	super()
	await animations.animation_finished
	is_complete = true

func process_frame(delta: float) -> State:
	if parent.velocity.x < 0:
		animations.flip_h = true
	elif parent.velocity.x > 0:
		animations.flip_h = false
	
	if is_complete:
		return charging_state
	return null
