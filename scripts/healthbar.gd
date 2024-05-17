extends ProgressBar
class_name HealthBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar

var health: float = 0 : set = _set_health

func init_health(_healt: float) -> void:
	health = _healt
	max_value = health
	value = health

func _set_health(new_health: float) -> void:
	var previous = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
	
	if health < previous:
		timer.start()


func _on_timer_timeout():
	damage_bar.value = health
