extends MeshInstance3D
class_name Mirror

@onready var camera_3d : Camera3D = $Camera3D

var mirror_material : StandardMaterial3D = null
var camera_feed

func _ready() -> void :
	set_mirror_texture()
	return

func set_mirror_texture() -> void :
	# Get the material of the mirror :
	mirror_material = mesh.surface_get_material(0).duplicate()
	# Get the camera texture (What the camera see) :
	camera_feed = camera_3d.get_viewport().get_texture()
	# Applying the camera feed to the material :
	mirror_material.set("albedo_texture" , camera_3d.get_viewport().get_texture())
	mesh.surface_set_material(0 , mirror_material)
	return
