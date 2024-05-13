extends CharacterBody2D
class_name Enemy

@export var MOVE_SPEED: float = 30
@export var friendly: bool = true

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var movement_state_machine = $MovementStateMachine
@onready var move_component = $MoveComponent
@onready var ray_cast_down = $RayCastDown


func _ready() -> void:
	movement_state_machine.init(self, animated_sprite, move_component)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)

func _process(delta: float):
	movement_state_machine.process_frame(delta)
