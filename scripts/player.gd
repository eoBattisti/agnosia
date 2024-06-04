extends CharacterBody2D
class_name Player

@onready var attack_animations = $attack_animations
@onready var movement_animations = $movement_animations
@onready var movement_state_machine = $MovementStateMachine
@onready var attack_state_machine = $AttackStateMachine
@onready var move_component = $MoveComponent
@onready var collision = $CollisionShape2D
@onready var weapon_hitbox = $WeaponHitbox
@onready var healthbar = $Healthbar
@onready var health_component = $HealthComponent
@onready var audio_stream_player = $AudioStreamPlayer


func _ready() -> void:
	GlobalManager.player = self
	movement_state_machine.init(self, movement_animations, audio_stream_player, move_component)
	attack_state_machine.init(self, attack_animations, audio_stream_player, move_component)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)
	attack_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)
	attack_state_machine.process_physics(delta)

func _process(delta: float):
	attack_state_machine.process_frame(delta)
	movement_state_machine.process_frame(delta)

func die():
	GlobalManager.respawn_player()
	healthbar.value = health_component.MAX_HEALTH
