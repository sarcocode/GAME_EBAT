extends Control

func _ready():
	$RestartButton.pressed.connect(_on_restart_button_pressed)
	$MainMenuButton.pressed.connect(_on_main_menu_button_pressed)

func _on_restart_button_pressed():
	print("Сыграть ещё раз нажато")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed():
	print("Главное меню нажато")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
