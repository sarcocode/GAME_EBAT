# ExitButton.gd
extends Button

func _ready():
	if not pressed.is_connected(_on_button_pressed):
		pressed.connect(_on_button_pressed)

func _on_button_pressed():
	if is_inside_tree():
		get_tree().quit()
