extends Control

@onready var slot1_button = $Slot1
@onready var slot2_button = $Slot2
@onready var slot3_button = $Slot3
@onready var back_button = $Back
@onready var clear_button = $Clear
@onready var name_input = $NameInput

var current_slot: int = 0
const SAVE_PATH = "user://savegame_%s.json"

func _ready():
	load_all_slots()
	connect_buttons()
	name_input.visible = false

func connect_buttons():
	slot1_button.pressed.connect(_on_slot_pressed.bind(1))
	slot2_button.pressed.connect(_on_slot_pressed.bind(2))
	slot3_button.pressed.connect(_on_slot_pressed.bind(3))
	back_button.pressed.connect(_on_back_pressed)
	clear_button.pressed.connect(_on_clear_pressed)
	name_input.text_submitted.connect(_on_name_input_text_submitted)

func load_all_slots():
	for i in range(1, 4):
		var save_file = FileAccess.open(SAVE_PATH % str(i), FileAccess.READ)
		if save_file:
			var json = JSON.new()
			var data = JSON.parse_string(save_file.get_as_text())
			if data.has("name"):
				get_node("Slot" + str(i)).text = data["name"]
			save_file.close()

func _on_slot_pressed(slot_number: int):
	current_slot = slot_number
	if FileAccess.file_exists(SAVE_PATH % str(slot_number)):
		var save_file = FileAccess.open(SAVE_PATH % str(slot_number), FileAccess.READ)
		var json = JSON.new()
		var data = JSON.parse_string(save_file.get_as_text())
		save_file.close()
		var level = data.get("level", 1)
		go_to_level_selection(level)
	else:
		name_input.visible = true
		name_input.clear()
		name_input.grab_focus()

func _on_name_input_text_submitted(new_text: String):
	if new_text.length() == 3:
		save_game(current_slot, new_text, 1) # Начинаем с уровня 1
		match current_slot:
			1: slot1_button.text = new_text
			2: slot2_button.text = new_text
			3: slot3_button.text = new_text
		name_input.visible = false
		go_to_level_selection(1)
	else:
		print("Name must be exactly 3 letters!")

func save_game(slot: int, save_name: String, level: int):
	var save_data = {
		"name": save_name,
		"level": level
	}
	
	var save_file = FileAccess.open(SAVE_PATH % str(slot), FileAccess.WRITE)
	if save_file:
		save_file.store_string(JSON.stringify(save_data))
		save_file.close()

func _on_clear_pressed():
	for i in range(1, 4):
		if FileAccess.file_exists(SAVE_PATH % str(i)):
			DirAccess.remove_absolute(SAVE_PATH % str(i))
		get_node("Slot" + str(i)).text = "Slot" + str(i)
	get_tree().reload_current_scene()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func go_to_level_selection(level: int):
	var level_choose_scene = preload("res://scenes/level_choose.tscn").instantiate()
	level_choose_scene.selected_level = level # Передаём последний доступный уровень
	get_tree().root.add_child(level_choose_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = level_choose_scene
