extends Node

@onready var char_scene = null

func set_char_scene(scene) :
	char_scene = scene
	return

func get_char_scene() :
	if char_scene :
		return char_scene
	return null
