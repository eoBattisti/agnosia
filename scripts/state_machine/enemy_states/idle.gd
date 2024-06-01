extends State
class_name EnemyIdleState

@export var move_state: State
@export var aware_state: State
@export var wander_state: State
@export var time_to_wander: float = 2.0

var _wander_timer: float

func enter() -> void:
	super()
	parent.velocity.x = 0
	_wander_timer = time_to_wander

func process_input(event: InputEvent) -> State:
	# If the enemy can't move, it only will be in idle state. If the enemy is in
	# attack mode, it will change to the aware state.
	if !parent.can_move:
		if (move_component._detected_player_right()
			or move_component._detected_player_left()):
				return aware_state
		return null

	# Change to the move state if detected the player in either raycasts direction.
	if (move_component._detected_player_right()
		or move_component._detected_player_left()):
		return move_state
	
	return null

func process_physics(delta: float) -> State:
	# Apply gravity to the enemy
	parent.velocity.y += gravity * delta
	parent.move_and_slide()

	return null

func process_frame(delta: float) -> State:
	# If the enemy can move, it change to the wander state to emulate a enemy's 
	# natural movement from time to time.
	if parent.can_move:
		_wander_timer -= delta
		if _wander_timer <= 0:
			return wander_state
	return null
