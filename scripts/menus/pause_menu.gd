extends Control

@onready var game = $"../../../../"

func _on_resume_button_pressed():
	game.pause_game()


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
