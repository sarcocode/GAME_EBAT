extends Button

var level_number = 0  # Переменная для хранения номера уровня

func _ready():
	text = str(level_number)  # Устанавливаем текст с номером
	connect("pressed", _on_pressed)  # Подключаем сигнал нажатия

func _on_pressed():
	print("Выбран уровень: ", level_number)
	var level_path = "res://scenes/level_" + str(level_number) + ".tscn"
	get_tree().change_scene_to_file(level_path)  # Переход на уровень
