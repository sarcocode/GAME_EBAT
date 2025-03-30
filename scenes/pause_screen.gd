extends Control

func _ready():
	$ResumeButton.pressed.connect(_on_resume_button_pressed)
	$MainMenuButton.pressed.connect(_on_main_menu_button_pressed)

func _on_resume_button_pressed():
	print("Продолжить нажато")
	get_tree().paused = false
	queue_free()

func _on_main_menu_button_pressed():
	print("Главное меню нажато")
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
