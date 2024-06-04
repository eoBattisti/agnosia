extends Node2D

@onready var pause_menu = $TileMap/Player/Camera2D/PauseMenu

var paused: bool = false

func _ready():
	TranslationServer.set_locale(GlobalManager.language)

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_game()

func pause_game() -> void:
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0

	paused = !paused
