extends State
class_name FallState

@export var idle_state: State
@export var move_state: State
@export var jump_state: State
@export var slide_state: State

@onready var coyote_timer = $"../CoyoteTimer"

func enter() -> void:
	super()
	coyote_timer.start()

func process_input(event: InputEvent) -> State:
	
	if !coyote_timer.is_stopped() and get_jump():
		jump_state.enter()

	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement = get_movement_input() * move_speed
	
	if movement != 0:
		if movement < 0:
			animations.flip_h = true
		elif  movement > 0:
			animations.flip_h = false
	
	parent.velocity.x = movement
	parent.move_and_slide()

	if parent.is_on_wall_only():
		return slide_state

	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null

func process_frame(delta: float) -> State:
	return null
