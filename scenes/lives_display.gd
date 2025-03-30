extends Node2D

# Ссылка на Label
@onready var label = $Label

# Количество жизней
var lives = 3

func _ready():
	update_display()

# Обновление текста на экране
func update_display():
	label.text = "Lives: " + str(lives)

# Уменьшение количества жизней
func decrease_lives():
	lives -= 1
	update_display()

# Проверка, закончились ли жизни
func is_game_over():
	return lives <= 0
