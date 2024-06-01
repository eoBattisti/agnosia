extends CharacterBody2D
class_name Enemy

@export var friendly: bool = true
@export var can_move: bool = true

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var movement_state_machine = $MovementStateMachine
@onready var move_component = $MoveComponent
@onready var enemy_hurt_state = $MovementStateMachine/EnemyHurtState
@onready var attack_state_machine = $AttackStateMachine
@onready var attack_hitbox = $AttackHitbox
@onready var melee_range_left = $MeleeRangeLeft
@onready var melee_range_right = $MeleeRangeRight


signal enemy_hurt

func _ready() -> void:
	movement_state_machine.init(self, animated_sprite, move_component)
	if attack_state_machine != null:
		attack_state_machine.init(self, animated_sprite, move_component)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)
	if attack_state_machine != null:
		attack_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)
	if attack_state_machine != null:
		attack_state_machine.process_physics(delta)
		#print(attack_state_machine.current_state)

func _process(delta: float):
	movement_state_machine.process_frame(delta)
	if attack_state_machine != null:	
		attack_state_machine.process_frame(delta)

func _on_enemy_hurt():
	movement_state_machine.change_state(enemy_hurt_state)
	if attack_state_machine != null:
		attack_state_machine.change_state(enemy_hurt_state)
