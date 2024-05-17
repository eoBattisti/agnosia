extends Node
class_name GameManager

enum LocalizationEnum {
	en,
	pt,
}

@export var language_choice: LocalizationEnum

var score = 0
var dialog_file: Dictionary
var language: String


func _ready():
	dialog_file = load_dialogs_file()
	language = LocalizationEnum.keys()[language_choice]


func add_point():
	score += 1

func load_dialogs_file() -> Dictionary:
	var file = FileAccess.open("res://assets/files/dialogs.json", FileAccess.READ)
	var content_text = file.get_as_text()
	return JSON.parse_string(content_text)

func get_npcs_dialog_lines(npc: String) -> Array:
	return dialog_file.get(npc).get(language)
