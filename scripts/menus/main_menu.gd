extends Control

@onready var start_button = $VBoxContainer2/VBoxContainer/StartButton

func _ready():
	start_button.grab_focus()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/options_menu.tscn")

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/credits_menu.tscn")


func _on_controls_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/controls_menu.tscn")	
