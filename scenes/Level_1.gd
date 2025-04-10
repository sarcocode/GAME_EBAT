extends Node2D

func _ready():
	var block_scene = preload("res://elements/block.tscn")  # Загружаем сцену блока
	
	# Параметры для свастики
	var size = 15  # Размер сетки (должен быть нечетным и >= 15 для 3-рядных ветвей)
	var center = size / 2  # Центр свастики
	var spacing = 20   # Расстояние между блоками
	
	# Устанавливаем разрешение экрана 540×960
	var screen_width = 540
	var screen_height = 960
	
	# Вычисляем начальные координаты для центрирования
	var total_width = size * spacing  # Общая ширина свастики в пикселях
	var total_height = size * spacing  # Общая высота свастики в пикселях
	var start_x = (screen_width - total_width) / 2  # Центрируем по горизонтали
	var start_y = (screen_height - total_height) / 2  # Центрируем по вертикали
	
	# Создаем свастику
	for y in range(size):
		for x in range(size):
			var should_place = false
			
			# Центральный крест (3 ряда толщиной)
			if (x >= center - 1 and x <= center + 1) or (y >= center - 1 and y <= center + 1):
				should_place = true
			
			# Верхний правый крюк (3 ряда)
			if (y < center - 1) and (x > center + 1) and (y >= 0) and (y <= 2):
				should_place = true
			# Нижний правый крюк (3 ряда)
			if (y > center + 1) and (x > center + 1) and (x >= size - 3) and (x <= size - 1):
				should_place = true
			# Нижний левый крюк (3 ряда)
			if (y > center + 1) and (x < center - 1) and (y >= size - 3) and (y <= size - 1):
				should_place = true
			# Верхний левый крюк (3 ряда)
			if (y < center - 1) and (x < center - 1) and (x >= 0) and (x <= 2):
				should_place = true
			
			# Убираем лишние блоки там, где крюки пересекаются с крестом
			if (x == center - 2 or x == center + 2) and (y == center - 2 or y == center + 2):
				should_place = false
			
			if should_place:
				var block = block_scene.instantiate()
				block.position = Vector2(
					start_x + x * spacing,
					start_y + y * spacing
				)
				block.add_to_group("Blocks")
				add_child(block)
