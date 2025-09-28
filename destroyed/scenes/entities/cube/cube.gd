extends StaticBody3D
class_name Cube

signal go_to_day

@onready var ray_cast_3d : RayCast3D = $RayCast3D
@onready var mesh_dream_cube : MeshInstance3D = $MeshDreamCube
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var base_position : Marker3D = $BasePosition
@onready var sfx_player : AudioStreamPlayer3D = $SFXPlayer

@export var player_version : bool = false
@export var next_scene_wake_up : String = ""
@export var wake_up_dialogue : String = ""

var tween

func _ready() -> void :
	if player_version :
		var material = mesh_dream_cube.mesh.surface_get_material(0).duplicate()
		print(material.get("albedo_color"))
		material.set("albedo_color" , Color(1 , 0 , 0 , 1))
		material.set("emission" , Color(1 , 0 , 0 , 1))
		mesh_dream_cube.mesh.surface_set_material(0 , material)
	animation_floating()
	animation_turning_around()
	return

func _input(_event: InputEvent) -> void :
	if Input.is_action_just_pressed("interact") : action()
	return

func action() -> void :
	if ray_cast_3d.is_colliding() :
		if next_scene_wake_up != "" :
			go_to_day.emit()
			play_SFX("res://assets/sounds/Retro Electric 21.wav")
			animation_player.play("touched")
	return

func play_SFX(sfx_path : String) -> void :
	if sfx_player.playing :
		sfx_player.stop()
	var sfx = load(sfx_path)
	sfx_player.stream = sfx
	sfx_player.play()
	return

#region animations
func animation_floating() -> void :
	tween = create_tween()
	tween.tween_property(mesh_dream_cube , "global_position" , Vector3(global_position.x , global_position.y + 0.6 , global_position.z) , 2.5)
	await  tween.finished
	tween.kill()
	await get_tree().create_timer(0.5).timeout
	tween = create_tween()
	tween.tween_property(mesh_dream_cube , "global_position" , base_position.global_position , 3.0)
	await  tween.finished
	tween.kill()
	await get_tree().create_timer(0.3).timeout
	animation_floating()
	return

func animation_turning_around() -> void :
	animation_player.play("turning_around")
	return

func _on_animation_player_animation_finished(anim_name : StringName) -> void :
	if anim_name == "turning_around" :
		animation_turning_around()
		return
	return
#endregion
