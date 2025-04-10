# RestartLevelButton.gd
extends Button

var current_level_path: String

func _ready():
	if not pressed.is_connected(_on_button_pressed):
		pressed.connect(_on_button_pressed)

func _on_button_pressed():
	if is_inside_tree() and ResourceLoader.exists(current_level_path):
		get_parent().queue_free()  # Удаляем game_over.tscn
		get_tree().change_scene_to_file(current_level_path)
