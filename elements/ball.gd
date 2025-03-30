extends CharacterBody2D

# Скорость мяча
var speed = 400.0
# Начальное направление мяча
var direction = Vector2(0, -1).normalized()
# Максимальный угол отскока (в радианах)
var max_bounce_angle = deg_to_rad(75)
# Флаг, чтобы остановить игру после проигрыша
var game_over = false

func _ready():
	# Задаем начальную скорость мяча
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	# Если игра окончена, не двигаем мяч
	if game_over:
		return
	
	# Двигаем мяч и проверяем столкновения
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		# Получаем объект, с которым столкнулись
		var collider = collision.get_collider()
		
		# Проверяем, столкнулись ли мы с платформой
		if collider.name == "Platform":
			# Вычисляем точку контакта относительно центра платформы
			var collision_point = collision.get_position().x
			var platform_center = collider.global_position.x
			var platform_width = 100.0  # Настрой ширину платформы
			
			# Нормализованное смещение от центра платформы (-1 для левого края, 1 для правого)
			var offset = (collision_point - platform_center) / (platform_width / 2.0)
			offset = clamp(offset, -1.0, 1.0)
			
			# Вычисляем угол отскока
			var bounce_angle = offset * max_bounce_angle
			direction = Vector2(0, -1).rotated(bounce_angle).normalized()
			velocity = direction * speed
		
		# Проверяем, столкнулись ли мы с блоком
		elif collider.is_in_group("Blocks"):
			collider.queue_free()  # Удаляем блок
			velocity = velocity.bounce(collision.get_normal())
		
		else:
			# Если столкнулись с чем-то другим (например, стенами), просто отражаем
			velocity = velocity.bounce(collision.get_normal())
	
	# Проверяем, улетел ли мяч за нижнюю границу экрана
	var screen_height = get_viewport().size.y
	if position.y > screen_height:
		game_over = true
		show_game_over_screen()

func show_game_over_screen():
	print("Game Over! Добавляем экран...")
	# Ставим игру на паузу
	get_tree().paused = true
	
	# Загружаем и добавляем сцену GameOver
	var game_over_scene = preload("res://scenes/game_over.tscn")
	var game_over_instance = game_over_scene.instantiate()
	
	# Делаем так, чтобы UI работал даже при паузе
	game_over_instance.process_mode = Node.PROCESS_MODE_ALWAYS

	get_tree().root.add_child(game_over_instance)
