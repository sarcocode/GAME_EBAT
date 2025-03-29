extends CharacterBody2D

# Скорость мяча
var speed = 400.0
# Начальное направление мяча
var direction = Vector2(0, -1).normalized()
# Максимальный угол отскока (в радианах)
var max_bounce_angle = deg_to_rad(75)

func _ready():
	# Задаем начальную скорость мяча
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	# Двигаем мяч и проверяем столкновения
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		# Получаем объект, с которым столкнулись
		var collider = collision.get_collider()
		
		# Проверяем, столкнулись ли мы с платформой
		if collider.name == "Platform":  # Замени "Platform" на имя твоей платформы
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
			# Удаляем блок
			collider.queue_free()
			# Отражаем мяч
			velocity = velocity.bounce(collision.get_normal())
		
		else:
			# Если столкнулись с чем-то другим (например, стенами), просто отражаем
			velocity = velocity.bounce(collision.get_normal())
			
			# Это проверка гита друзья мои
			
			proverka gitaaaaaaaaaaaa
