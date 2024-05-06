extends Node2D

@onready var interaction_area = $InteractionArea
@onready var animated_sprite = $AnimatedSprite2D

const lines: Array[String] = [
	"Hey there",
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	animated_sprite.flip_h = true if interaction_area.get_overlapping_bodies()[0].global_position.x < global_position.x else false
	await DialogManager.dialog_finished
