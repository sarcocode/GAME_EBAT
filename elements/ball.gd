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
@onready var platform = get_parent().get_node("Platform")
@onready var lives_display = get_parent().get_node("LivesDisplay")

func _ready():
	initial_position = platform.global_position + Vector2(-55, -100)
	position = initial_position
	velocity = Vector2.ZERO
	# Выводим начальное количество блоков
	var blocks = get_tree().get_nodes_in_group("Blocks")
	print("Начальное количество блоков: ", blocks.size())
	for block in blocks:
		print("Блок: ", block.name, " | Позиция: ", block.global_position, " | Видимый: ", block.visible)

func _physics_process(delta: float) -> void:
	if is_waiting:
		position = initial_position
		if Input.is_action_just_pressed("ui_accept"):
			is_waiting = false
			velocity = direction * speed
		return
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		
		if collider.name == "Platform":
			var collision_point = collision.get_position().x
			var platform_center = collider.global_position.x
			var platform_width = 100.0
			var offset = clamp((collision_point - platform_center) / (platform_width / 2.0), -1.0, 1.0)
			var bounce_angle = offset * max_bounce_angle
			direction = Vector2(0, -1).rotated(bounce_angle).normalized()
			velocity = direction * speed
		
		elif collider.is_in_group("Blocks"):
			collider.queue_free()
			velocity = velocity.bounce(collision.get_normal())
			await collider.tree_exited  # Ждем удаления блока
			check_win_condition()
		
		else:
			velocity = velocity.bounce(collision.get_normal())
	
	var screen_height = get_viewport().size.y
	if position.y > screen_height:
		lives_display.decrease_lives()
		if not lives_display.is_game_over():
			is_waiting = true
			position = initial_position
			velocity = Vector2.ZERO
			print("Осталось жизней: ", lives_display.lives)
		else:
			show_game_over_screen()

func check_win_condition():
	var blocks = get_tree().get_nodes_in_group("Blocks")
	print("Осталось блоков: ", blocks.size())  # Выводим количество оставшихся блоков
	if blocks.size() == 0:
		show_win_screen()
	else:
		print("Следующие блоки остались в группе 'Blocks':")
		for block in blocks:
			print("Блок: ", block.name, " | Позиция: ", block.global_position, " | Видимый: ", block.visible)

func show_win_screen():
	print("Победа! Все блоки уничтожены!")
	get_tree().paused = true
	var win_screen_scene = preload("res://scenes/win_screen.tscn")
	var win_screen_instance = win_screen_scene.instantiate()
	win_screen_instance.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().root.add_child(win_screen_instance)

func show_game_over_screen():
	print("Game Over! Жизни закончились!")
	get_tree().paused = true
	var game_over_scene = preload("res://scenes/game_over.tscn")
	var game_over_instance = game_over_scene.instantiate()
	game_over_instance.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().root.add_child(game_over_instance)
