# RestartLevelButton.gd
extends Button

var current_level_path: String

func _ready():
	if not pressed.is_connected(_on_button_pressed):
		pressed.connect(_on_button_pressed)

func _on_button_pressed():
	var current_scene = get_tree().current_scene
#
	var root = get_tree().root
	var current_level = root.get_child(root.get_child_count() - 2)
	var level_path = current_level.scene_file_path
	
	get_tree().paused = false
	get_parent().queue_free()
	get_tree().change_scene_to_file(level_path)
