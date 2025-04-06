extends Control

func _ready():
	# Подключаем сигналы кнопок
	$StartButton.pressed.connect(_on_play_button_pressed)
	$ExitButton.pressed.connect(_on_exit_button_pressed)

func _on_play_button_pressed():
	# Переходим в игровую сцену
	get_tree().change_scene_to_file("res://scenes/level_choose.tscn")

func _on_exit_button_pressed():
	# Выходим из игры
	get_tree().quit()
