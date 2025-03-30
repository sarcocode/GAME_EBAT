extends CharacterBody2D

# Скорость мяча
var speed = 400.0
# Начальное направление мяча
var direction = Vector2(0, -1).normalized()
# Максимальный угол отскока (в радианах)
var max_bounce_angle = deg_to_rad(75)
# Флаг ожидания запуска
var is_waiting = true
# Начальная позиция мяча
var initial_position = Vector2.ZERO
# Ссылки на платформу и отображение жизней
@onready var platform = get_parent().get_node("Platform")  # Убедись, что платформа называется "Platform"
@onready var lives_display = get_parent().get_node("LivesDisplay")  # Ссылка на LivesDisplay

func _ready():
	# Устанавливаем начальную позицию над платформой
	initial_position = platform.global_position + Vector2(-55, -100)  # 20 пикселей над платформой
	position = initial_position
	velocity = Vector2.ZERO  # Мяч неподвижен до запуска

func _physics_process(delta: float) -> void:
	# Если мяч ждёт запуска
	if is_waiting:
		position = initial_position
		if Input.is_action_just_pressed("ui_accept"):  # Пробел
			is_waiting = false
			velocity = direction * speed
		return
	
	# Двигаем мяч и проверяем столкновения
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		
		# Столкновение с платформой
		if collider.name == "Platform":
			var collision_point = collision.get_position().x
			var platform_center = collider.global_position.x
			var platform_width = 100.0  # Ширина платформы
			var offset = clamp((collision_point - platform_center) / (platform_width / 2.0), -1.0, 1.0)
			var bounce_angle = offset * max_bounce_angle
			direction = Vector2(0, -1).rotated(bounce_angle).normalized()
			velocity = direction * speed
		
		# Столкновение с блоками
		elif collider.is_in_group("Blocks"):
			collider.queue_free()
			velocity = velocity.bounce(collision.get_normal())
		
		# Столкновение со стенами
		else:
			velocity = velocity.bounce(collision.get_normal())
	
	# Проверяем вылет за нижнюю границу
	var screen_height = get_viewport().size.y
	if position.y > screen_height:
		lives_display.decrease_lives()  # Уменьшаем жизни
		if not lives_display.is_game_over():
			# Если жизни остались, возвращаем мяч
			is_waiting = true
			position = initial_position
			velocity = Vector2.ZERO
			print("Осталось жизней: ", lives_display.lives)
		else:
			# Если жизни закончились, показываем Game Over
			show_game_over_screen()

func show_game_over_screen():
	print("Game Over! Жизни закончились!")
	get_tree().paused = true
	var game_over_scene = preload("res://scenes/game_over.tscn")
	var game_over_instance = game_over_scene.instantiate()
	game_over_instance.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().root.add_child(game_over_instance)
