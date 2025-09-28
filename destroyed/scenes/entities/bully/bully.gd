extends MeshInstance3D
class_name Bully

var sprites : Dictionary[String , String] = {
	"normal" : "res://assets/sprites/bully_sprites/bully_normal.png" ,
	"talk" : "res://assets/sprites/bully_sprites/bully_talk.png" ,
	"insistant" : "res://assets/sprites/bully_sprites/bully_insistant.png" ,
	"chocked" : "res://assets/sprites/bully_sprites/bully_chocked.png" ,
	"sarcasm" : "res://assets/sprites/bully_sprites/bully_sarcasm.png"
}

func change_sprite(sprite_name : String) -> void :
	if sprite_name in sprites :
		var new_sprite = load(sprites[sprite_name])
		# Change the sprite :
		var material = mesh.surface_get_material(0).duplicate()
		material.set("albedo_texture" , new_sprite)
		mesh.surface_set_material(0 , material)
	return
