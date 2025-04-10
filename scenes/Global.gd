# Global.gd (должен быть в AutoLoad)
extends Node

var current_level_path: String = "res://scenes/Level_1.tscn"

func set_current_level(path: String):
	current_level_path = path
