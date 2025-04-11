extends Control

@onready var back_button = $Back
var selected_level: int = 1 # Последний доступный уровень из сохранения

func _ready():
	var button_scene = preload("res://scenes/button_of_level_choose.tscn")
	var rows = 3
	var cols = 4
	var button_size = Vector2(100, 100)
	var spacing_x = 20
	var spacing_y = 20
	var screen_width = 540
	var screen_height = 960
	
	var grid_width = cols * button_size.x + (cols - 1) * spacing_x
	var grid_height = rows * button_size.y + (rows - 1) * spacing_y
	var start_x = (screen_width - grid_width) / 2
	var start_y = (screen_height - grid_height) / 2
	
	var level_counter = 1
	for row in range(rows):
		for col in range(cols):
			var button = button_scene.instantiate()
			button.level_number = level_counter
			button.size = button_size
			button.position = Vector2(
				start_x + col * (button_size.x + spacing_x),
				start_y + row * (button_size.y + spacing_y)
			)
			if level_counter > selected_level:
				button.disabled = true # Блокируем недоступные уровни
			add_child(button)
			level_counter += 1
	
	back_button.pressed.connect(_on_back_pressed)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/save_slots.tscn")
