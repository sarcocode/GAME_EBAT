extends Button

@export var level_number: int = 1

func _ready():
	text = str(level_number) # Отображаем номер уровня на кнопке
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	# Загружаем сцену уровня
	var level_scene = preload("res://scenes/Levels.tscn").instantiate()
	level_scene.level_number = level_number # Передаём номер уровня
	get_tree().root.add_child(level_scene)
	get_tree().current_scene.queue_free() # Удаляем текущую сцену (выбор уровней)
	get_tree().current_scene = level_scene
