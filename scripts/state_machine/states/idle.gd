extends State
class_name IdleState

@export var dash_state: State
@export var fall_state: State
@export var jump_state: State
@export var move_state: State
@export var rest_state: State
@export var time_to_rest: float

var _rest_timer: float

func enter() -> void:
	super()
	parent.velocity.x = 0
	_rest_timer = time_to_rest

func process_input(event: InputEvent) -> State:
	if get_hide():
		if animations.animation == 'hide':
			animations.play("unhide")
		else:
			animations.play("hide")
		
	if get_jump() and parent.is_on_floor():
		return jump_state
	if get_movement_input() != 0:
		return move_state
	if get_dash():
		return dash_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null

func process_frame(delta: float) -> State:
	
	_rest_timer -= delta
	if _rest_timer <= 0:
		return rest_state
	return null
