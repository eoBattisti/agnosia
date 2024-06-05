extends Node

enum LocalizationEnum {
	en,
	pt,
}

@export var language_choice: LocalizationEnum

var enemies_defeated = 0
var npcs_died = 0
var score = 0
var dialog_file: Dictionary
var language: String

var current_checkpoint: Checkpoint
var player: Player

func _ready():
	dialog_file = load_dialogs_file()
	language = LocalizationEnum.keys()[language_choice]
	TranslationServer.set_locale(language)

func _set_language(index: int) -> void:
	language = LocalizationEnum.keys()[index]
	TranslationServer.set_locale(language)

func add_point():
	score += 1

func load_dialogs_file() -> Dictionary:
	var file = FileAccess.open("res://assets/files/dialogs.json", FileAccess.READ)
	var content_text = file.get_as_text()
	return JSON.parse_string(content_text)

func get_npcs_dialog_lines(npc: String) -> Array:
	print(npc)
	return dialog_file.get(npc).get(language)
	
func respawn_player() -> void:
	if current_checkpoint != null:
		player.global_position = current_checkpoint.global_position

