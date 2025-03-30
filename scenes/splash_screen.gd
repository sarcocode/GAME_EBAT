extends Control

# Время показа сплеш-скрина в секундах
const SHOW_TIME = 3.0

func _ready():
	# Создаём таймер на 3 секунды
	await get_tree().create_timer(SHOW_TIME).timeout
	# Переходим в главное меню после таймера
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
