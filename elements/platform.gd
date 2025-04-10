extends CharacterBody2D

const SPEED = 300.0

func _physics_process(_delta: float) -> void:
	# Получаем направление движения (влево/вправо)
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Устанавливаем скорость только по оси X
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Фиксируем ось Y, чтобы платформа не двигалась вверх или вниз
	velocity.y = 0
	
	# Используем move_and_slide для движения
	move_and_slide()
	
	## Дополнительно фиксируем позицию по Y после движения, чтобы исключить любой дрейф
	#position.y = 500  # Замени 500 на начальную Y-координату твоей платформы
