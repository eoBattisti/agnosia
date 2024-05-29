extends State
class_name EAttackIdleState

@export var attacking_state: State
@export var hitbox: AttackHitbox

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if !parent.friendly and move_component._detected_player_left():
		return attacking_state
	return null
	
func process_frame(delta: float) -> State:
	if parent.velocity.x < 0:
		animations.flip_h = true
	elif parent.velocity.x > 0:
		animations.flip_h = false

	return null
