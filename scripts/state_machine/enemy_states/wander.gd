extends State
class_name EnemyWanderState

@export var idle_state: State
var wander_timer: float
var random_direction: float

func enter() -> void:
	super()
	wander_timer = move_component.get_wander_time()
	random_direction = move_component.get_random_direction()

func process_frame(delta: float) -> State:
	if parent.velocity.x < 0:
		animations.flip_h = true
	elif parent.velocity.x > 0:
		animations.flip_h = false

	
	if random_direction == 0 or move_component._detect_fall():
		return idle_state

	parent.velocity.y += gravity * delta
	parent.velocity.x = move_speed * random_direction
	parent.move_and_slide()

	wander_timer -= delta
	if wander_timer <= 0.0:
		return idle_state

	return null
