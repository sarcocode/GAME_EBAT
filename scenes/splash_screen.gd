extends Control

func _ready():
	# Если есть анимация, проигрываем её
	if has_node("AnimationPlayer"):
		$AnimationPlayer.play("fade_in_out")
		# Ждем, пока анимация закончится
		await $AnimationPlayer.animation_finished
	else:
		# Если анимации нет, просто ждем 3 секунды
		await get_tree().create_timer(3.0).timeout
	
	# Переходим к главному меню
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
