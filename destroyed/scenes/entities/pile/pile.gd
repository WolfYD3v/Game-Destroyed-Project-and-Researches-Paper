extends Node3D
class_name Pile

@onready var model : Node3D = $Model
@onready var spot_light_3d : SpotLight3D = $SpotLight3D
@onready var sfx_player : AudioStreamPlayer3D = $SFXPlayer
@onready var text_mesh : MeshInstance3D = $Model/TextMesh
@onready var player_detection_area : Area3D = $PlayerDetectionArea

@export var pile_name : String

func _ready() -> void :
	spot_light_3d.hide()
	model.hide()
	return

func play_sfx(sfx_path : String , volume_db : float , pitch_scale : float) -> void :
	sfx_player.stream = load(sfx_path)
	sfx_player.volume_db = volume_db
	sfx_player.pitch_scale = pitch_scale
	sfx_player.play()
	return

func _on_player_detection_area_body_entered(_body : Node3D) -> void :
	if not model.visible :
		spot_light_3d.show()
		model.show()
		play_sfx("res://assets/sounds/Retro Impact 20.wav" , 30.0 , 2.0)
		text_mesh.mesh.set("text" , pile_name)
	return

func _on_player_detection_area_body_exited(_body : Node3D) -> void :
	if model.visible :
		spot_light_3d.hide()
		model.hide()
		play_sfx("res://assets/sounds/Retro Impact 20.wav" , 30.0 , 0.7)
	return
