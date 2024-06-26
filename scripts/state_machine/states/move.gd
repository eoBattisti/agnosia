extends State
class_name MoveState

@export var dash_state: State
@export var fall_state: State
@export var idle_state: State
@export var jump_state: State
@export var counter_dash_state: State

@onready var dash_timer = $"../DashTimer"
@onready var counter_dash_timer = $"../CounterDashTimer"

var can_dash: bool = true
var can_counter_dash: bool = true

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if get_dash() and can_dash:
		can_dash = false
		dash_timer.start()
		return dash_state
	
	if get_counter_dash() and can_counter_dash:
		can_counter_dash = false
		counter_dash_timer.start()
		return counter_dash_state

	return null

func process_physics(delta: float) -> State:
	if get_jump() and parent.is_on_floor():
		return jump_state
	
	parent.velocity.y += gravity * delta
	var movement = get_movement_input() * move_speed
	
	if movement == 0:
		return idle_state

	animations.flip_h = movement < 0
	if animations.flip_h:
		parent.weapon_hitbox.scale = Vector2(-1, 1)
	else:
		parent.weapon_hitbox.scale = Vector2(1, 1)

	parent.velocity.x = movement
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null


func _on_dash_timer_timeout():
	can_dash = true

func _on_counter_dash_timer_timeout():
	print("Here")
	can_counter_dash = true
