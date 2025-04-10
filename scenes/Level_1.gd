# Level_1.gd
extends Node2D

var lives = 3
var current_level_path: String

func _ready():
	current_level_path = get_tree().current_scene.scene_file_path
	lives = 3
	
	var block_scene = preload("res://elements/block.tscn")
	var size = 15
	var center = size / 2
	var spacing = 20
	var screen_width = 540
	var screen_height = 960
	var total_width = size * spacing
	var total_height = size * spacing
	var start_x = (screen_width - total_width) / 2
	var start_y = (screen_height - total_height) / 2
	
	for y in range(size):
		for x in range(size):
			var should_place = false
			if (x >= center - 1 and x <= center + 1) or (y >= center - 1 and y <= center + 1):
				should_place = true
			if (y < center - 1) and (x > center + 1) and (y >= 0) and (y <= 2):
				should_place = true
			if (y > center + 1) and (x > center + 1) and (x >= size - 3) and (x <= size - 1):
				should_place = true
			if (y > center + 1) and (x < center - 1) and (y >= size - 3) and (y <= size - 1):
				should_place = true
			if (y < center - 1) and (x < center - 1) and (x >= 0) and (x <= 2):
				should_place = true
			if (x == center - 2 or x == center + 2) and (y == center - 2 or y == center + 2):
				should_place = false
			
			if should_place:
				var block = block_scene.instantiate()
				block.position = Vector2(start_x + x * spacing, start_y + y * spacing)
				block.add_to_group("Blocks")
				add_child(block)

func _on_player_lost():
	lives -= 1
	if lives <= 0:
		if is_inside_tree():
			current_level_path = get_tree().current_scene.scene_file_path
			var game_over_scene = preload("res://scenes/game_over.tscn").instantiate()
			game_over_scene.set("current_level_path", current_level_path)
			add_child(game_over_scene)  # Добавляем как дочерний узел
