extends MeshInstance3D
class_name Girl

var sprites : Dictionary[String , String] = {
	"student" : "res://assets/sprites/girl_sprites/student.png" ,
	"stressing" : "res://assets/sprites/girl_sprites/stressing.png" ,
	"sad" : "res://assets/sprites/girl_sprites/sad.png" ,
	"kind" : "res://assets/sprites/girl_sprites/kind.png" ,
	"intresting" : "res://assets/sprites/girl_sprites/intresting.png" ,
	"comprehensive" : "res://assets/sprites/girl_sprites/comprehensive.png"
}

func change_sprite(sprite_name : String) -> void :
	if sprite_name in sprites :
		var new_sprite = load(sprites[sprite_name])
		# Change the sprite :
		var material = mesh.surface_get_material(0).duplicate()
		material.set("albedo_texture" , new_sprite)
		mesh.surface_set_material(0 , material)
	return
