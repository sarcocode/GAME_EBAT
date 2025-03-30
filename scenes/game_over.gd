extends Control  # Или Node2D, в зависимости от корневого узла в GameOver.tscn

func _ready():
	# Подключаем сигналы кнопок
	$RestartButton.pressed.connect(_on_restart_button_pressed)
	$MainMenuButton.pressed.connect(_on_main_menu_button_pressed)

func _on_restart_button_pressed():
	print("Рестарт нажат")
	get_tree().paused = false  # Снимаем паузу
	get_tree().reload_current_scene()  # Перезапускаем текущую сцену (Game.tscn)

func _on_main_menu_button_pressed():
	print("Мейн меню нажат")
	get_tree().paused = false  # Снимаем паузу
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")  # Переход в главное меню
