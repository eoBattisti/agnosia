extends Node2D
class_name Npc

enum NpcEnum {
	Sold_a,
	Sold_b
}

@onready var interaction_area = $InteractionArea
@onready var animated_sprite = $AnimatedSprite2D

@export var npc_name: NpcEnum

var lines: Array

func _ready():
	lines = GlobalManager.get_npcs_dialog_lines(str(npc_name))
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	animated_sprite.flip_h = true if interaction_area.get_overlapping_bodies()[0].global_position.x < global_position.x else false
	await DialogManager.dialog_finished
