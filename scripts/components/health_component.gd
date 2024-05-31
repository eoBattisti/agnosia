extends Node2D
class_name HealthComponent

@export var MAX_HEALTH: float = 10.0
@onready var healthbar = $"../Healthbar"

var health: float

func _ready():
	health = MAX_HEALTH
	if healthbar:
		healthbar.init_health(health)

func damage(attack: Attack):
	health -= attack.damage
	
	if healthbar:
		healthbar.health = health

	if health <= 0:
		var parent = get_parent()
		if parent is Player:
			parent.die()
		else:
			parent.queue_free()
