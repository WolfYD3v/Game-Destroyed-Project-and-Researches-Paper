extends Node3D
class_name Day

@onready var dialogues_menu : Node3D = $DialoguesMenu
@onready var bully_mesh = $BullyMesh

@export var dialogue_id : String = ""
@export var next_scene_dream : String

func _ready() -> void :
	play_dialogue()
	await dialogues_menu.dialogue_box.dialogue_ended
	get_tree().change_scene_to_file(next_scene_dream)
	return

func play_dialogue() -> void :
	if dialogue_id != "" :
		dialogues_menu.play_dialogue(dialogue_id)
	return

func change_bully_sprite(sprite_name) -> void :
	bully_mesh.change_sprite(sprite_name)
	return
