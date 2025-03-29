extends Control

func _ready():
	# Ждем 3 секунды, затем переходим в главное меню
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
