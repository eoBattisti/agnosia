extends Node2D
class_name Checkpoint

var activated: bool = false

func activate() -> void:
	activated = true
	GlobalManager.current_checkpoint = self


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player and !activated:
		activate()
