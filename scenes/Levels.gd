extends Node2D

var lives: int = 3
var current_level_path: String
@export var level_number: int = 1

func _ready():
	current_level_path = get_tree().current_scene.scene_file_path
	lives = 3
	load_level(level_number)

func load_level(level_num: int):
	var file_path = "res://levels/level_%d.json" % level_num
	var file = FileAccess.open(file_path, FileAccess.READ)
	if not file:
		print("Level file not found: ", file_path)
		return
	
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	file.close()
	
	if error != OK:
		print("Error parsing JSON: ", json.get_error_message())
		return
	
	var data = json.data
	var block_scene = preload("res://elements/block.tscn")
	
	var rows = data["rows"]
	var cols = data["cols"]
	var start_x = data["start_x"]
	var start_y = data["start_y"]
	var spacing_x = data["spacing_x"]
	var spacing_y = data["spacing_y"]
	var blocks = data["blocks"]
	
	for y in range(rows):
		for x in range(cols):
			var should_place = false
			if blocks.is_empty():
				should_place = true # Для уровней вроде level_2.json (все блоки)
			elif y < blocks.size() and x < blocks[y].size():
				should_place = blocks[y][x] == 1
			
			if should_place:
				var block = block_scene.instantiate()
				block.position = Vector2(start_x + x * spacing_x, start_y + y * spacing_y)
				block.add_to_group("Blocks")
				add_child(block)

func _on_player_lost():
	lives -= 1
	if lives <= 0:
		if is_inside_tree():
			var game_over_scene = preload("res://scenes/game_over.tscn").instantiate()
			game_over_scene.set("current_level_path", current_level_path)
			add_child(game_over_scene)
