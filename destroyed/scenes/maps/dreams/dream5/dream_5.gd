extends Dream

signal tex_looping

@onready var walk_label : Label = $CanvasLayer/WalkLabel
@onready var invisible_wall_3 : StaticBody3D = $Map/InvisibleWall3
@onready var _01_to_03 : MeshInstance3D = $"Map/Dialogs/01to03"
@onready var pile_4 : Node3D = $Map/Piles/Pile4
@onready var pile_4_spot_light : SpotLight3D = $Map/Piles/Pile4SpotLight
@onready var wall_2 : StaticBody3D = $Map/Wall2

func _ready() -> void :
	pile_4_spot_light.hide()
	pile_4.hide()
	walk_label.hide()
	player_direction_arrow.hide()
	everything_is_fine.hide()
	new_day_text.hide()
	start_dream_ambiance()
	animation_player.play("Fading_out")
	cameras_management()
	is_dream_tutorial()
	player.stucked = true
	player_direction_arrow.show()
	await animation_player.animation_finished
	change_texture_looping(_01_to_03 , ["res://assets/textures/Dream 5/02.png" , "res://assets/textures/Dream 5/03.png"] , 5.5)
	await tex_looping
	invisible_wall_3.call_deferred("queue_free")
	walk_label.show()
	await get_tree().create_timer(2.5).timeout
	walk_label.hide()
	return

func change_texture_looping(model : MeshInstance3D , tex_array : Array[String] , waiting_time : float) -> void :
	for tex in tex_array :
			await get_tree().create_timer(waiting_time).timeout
			change_texture(model , tex)
	tex_looping.emit()
	return

func change_texture(model : MeshInstance3D , tex) :
	var mat : StandardMaterial3D = model.mesh.surface_get_material(0)
	mat.set("albedo_texture" , load(tex))
	model.mesh.surface_set_material(0 , mat)
	return

func _on_big_spot_light_body_entered(_body : Node3D) -> void :
	if not pile_4_spot_light.visible :
		pile_4_spot_light.show()
		pile_4.show()
		sfx_player.play()
	return

func _on_end_dream_body_entered(_body : Node3D) -> void :
	wall_2.call_deferred("queue_free")
	await get_tree().create_timer(25.0).timeout
	get_tree().change_scene_to_file("res://scenes/end/end.tscn")
	return
