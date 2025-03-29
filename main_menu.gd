extends Control

func _ready():
	# Подключаем сигнал кнопки
	$PlayAgainButton.pressed.connect(_on_play_again_pressed)

func _on_play_again_pressed():
	# Снимаем паузу и переходим в главное меню
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
