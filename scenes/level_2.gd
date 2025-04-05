extends Node2D

func _ready():
	var block_scene = preload("res://elements/block.tscn")  # Загружаем сцену блока
	
	# Параметры сетки
	var rows = 20       # Количество рядов
	var cols = 26      # Количество блоков в ряду
	var start_x = 20   # Начальная позиция X
	var start_y = 50   # Начальная позиция Y
	var spacing_x = 20  # Расстояние между блоками по X
	var spacing_y = 20  # Расстояние между блоками по Y
	
	# Создаем ряды блоков
	for row in range(rows):
		for col in range(cols):
			var block = block_scene.instantiate()  # Создаем экземпляр блока
			block.position = Vector2(
				start_x + col * spacing_x,
				start_y + row * spacing_y
			)
			block.add_to_group("Blocks")
			add_child(block)  # Добавляем блок в сцену
