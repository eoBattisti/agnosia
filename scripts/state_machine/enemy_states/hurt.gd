extends State
class_name EnemyHurtState

@export var idle_state: State
@export var knockback_force: int = 30
var is_complete: bool = false

func enter() -> void:
	is_complete = false
	super()
	await animations.animation_finished
	is_complete = true

func process_physics(delta: float) -> State:
	if parent.can_move:
		var direction = -parent.velocity * knockback_force 
		parent.velocity = direction
		parent.move_and_slide()
	return idle_state

