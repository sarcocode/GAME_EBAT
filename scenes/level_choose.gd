extends Control

@onready var back_button = $Back  # Ссылка на кнопку "Назад"

func _ready():
	var button_scene = preload("res://scenes/button_of_level_choose.tscn")  # Загружаем сцену кнопки
	
	# Параметры сетки
	var rows = 3  # 3 ряда
	var cols = 4  # 4 столбца (итого 12 кнопок)
	var button_size = Vector2(100, 100)  # Размер кнопки (ширина, высота)
	var spacing_x = 20  # Расстояние между кнопками по X
	var spacing_y = 20  # Расстояние между кнопками по Y
	
	# Разрешение экрана
	var screen_width = 540
	var screen_height = 960
	
	# Вычисляем общий размер сетки
	var grid_width = cols * button_size.x + (cols - 1) * spacing_x  # 4 кнопки + 3 промежутка
	var grid_height = rows * button_size.y + (rows - 1) * spacing_y  # 3 ряда + 2 промежутка
	
	# Вычисляем начальные координаты для центрирования
	var start_x = (screen_width - grid_width) / 2
	var start_y = (screen_height - grid_height) / 2
	
	# Счётчик для номеров уровней
	var level_counter = 1
	
	# Создаём кнопки в сетке 4×3
	for row in range(rows):
		for col in range(cols):
			var button = button_scene.instantiate()  # Создаём кнопку
			button.level_number = level_counter  # Присваиваем номер уровня
			# Устанавливаем позицию и размер
			button.size = button_size  # Устанавливаем размер кнопки
			button.position = Vector2(
				start_x + col * (button_size.x + spacing_x),
				start_y + row * (button_size.y + spacing_y)
			)
			add_child(button)  # Добавляем в сцену
			level_counter += 1  # Увеличиваем счётчик
	
	# Подключаем сигнал для кнопки "Назад"
	back_button.pressed.connect(_on_back_pressed)

func _on_back_pressed():
	# Переход на сцену выбора сохранений
	get_tree().change_scene_to_file("res://scenes/save_slots.tscn")
