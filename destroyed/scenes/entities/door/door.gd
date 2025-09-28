extends StaticBody3D
class_name Door

@onready var ray_cast_3d : RayCast3D = $RayCast3D
@onready var porte : Node3D = $Porte
@onready var sfx_player : AudioStreamPlayer3D = $SFXPlayer
@onready var sfx_player_2 : AudioStreamPlayer3D = $SFXPlayer2
@onready var text_mesh : MeshInstance3D = $TextMesh

@export var unlocked : bool = false
@export var test_opening : int = 1
@export var unvaible_text_open_door : String
@export var text_door_open : String

var _test_opening : int
var animation_playing : bool = false

func _ready() -> void :
	_test_opening = test_opening
	return

func _input(_event: InputEvent) -> void :
	if animation_playing :
		return
	if Input.is_action_just_pressed("interact") : action()
	return

func action() -> void :
	if ray_cast_3d.is_colliding() :
		if _test_opening <= 0 :
			return
		if _test_opening > 0 :
			_test_opening -= 1
			try_open()
			if _test_opening == 0 :
				show_text(unvaible_text_open_door)
		else :
			if unlocked :
				show_text(text_door_open)
				open_door()
	return

func show_text(text_input : String) -> void :
	var txt : String = ""
	for lettre in text_input :
		txt += lettre
		text_mesh.mesh.set("text" , txt)
		sfx_player_2.play()
		await get_tree().create_timer(0.1).timeout
	return

#region animations
func try_open() -> void :
	animation_playing = true
	sfx_player.play()
	for loop in range(4) :
		porte.global_position.y -= 0.3
		await get_tree().create_timer(0.1).timeout
	await get_tree().create_timer(0.2).timeout
	for loop in range(4) :
		porte.global_position.y += 0.3
		await get_tree().create_timer(0.1).timeout
	sfx_player.stop()
	animation_playing = false
	return

func open_door() -> void :
	animation_playing = true
	sfx_player.play()
	for loop in range(16) :
		porte.global_position.y -= 0.3
		await get_tree().create_timer(0.1).timeout
	sfx_player.stop()
	await get_tree().create_timer(0.05).timeout
	animation_playing = false
	get_tree().change_scene_to_file("res://scenes/end/end.tscn")
	return
#endregion
