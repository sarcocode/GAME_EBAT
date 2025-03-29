extends Control

func _ready():
	# Проверяем, существует ли узел PlayAgainButton
	if $PlayAgainButton:
		$PlayAgainButton.pressed.connect(_on_play_again_pressed)
		print("PlayAgainButton signal connected!")  # Отладочный вывод
	else:
		print("Error: PlayAgainButton not found!")

func _on_play_again_pressed():
	print("Play Again button pressed!")  # Отладочный вывод
	get_tree().paused = false
	print("Paused state after unpause:", get_tree().paused)  # Должно быть false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
