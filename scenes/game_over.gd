# GameOver.gd
extends Control

var current_level_path: String

func _ready():
	if has_node("RestartButton"):
		$RestartButton.current_level_path = current_level_path

func _exit_tree():
	if has_node("RestartButton") and $RestartButton.pressed.is_connected($RestartButton._on_button_pressed):
		$RestartButton.pressed.disconnect($RestartButton._on_button_pressed)
	if has_node("MainMenuButton") and $MainMenuButton.pressed.is_connected($MainMenuButton._on_button_pressed):
		$MainMenuButton.pressed.disconnect($MainMenuButton._on_button_pressed)
