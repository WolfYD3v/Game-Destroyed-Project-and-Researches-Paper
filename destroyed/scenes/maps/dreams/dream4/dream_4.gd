extends Dream

@onready var bin_memory : Node3D = $Map/BinMemory
@onready var draw_memory : Node3D = $Map/DrawMemory
@onready var dog_memory : Node3D = $Map/DogMemory
@onready var memories_scenes_player : AnimationPlayer = $MemoriesScenesPlayer
@onready var narrator_text_mesh : MeshInstance3D = $Map/NarratorTextMesh
@onready var text_sfx_player : AudioStreamPlayer3D = $TextSFXPlayer

var main_camera_starting_positions : Dictionary[String , Vector3] = {
	"Bin" : Vector3(0.0 , 5.5 , 8.0) ,
	"Draw" : Vector3(0.0 , 5.5 , -42.0) ,
	"Dog" : Vector3(0.0 , 5.5 , -92.0)
}
var player_starting_positions : Dictionary[String , Vector3] = {
	"Bin" : Vector3(-1.692 , 1.725 , 0.853) ,
	"Draw" : Vector3(-1.692 , 1.725 , -49.147) ,
	"Dog" : Vector3(-1.692 , 1.725 , -99.147)
}
var narrator_text_mesh_positions : Dictionary[String , Vector3] = {
	"Bin" : Vector3(-0.367 , 4.535 , -7.0) ,
	"Draw" : Vector3(-0.367 , 4.535 , -58.97) ,
	"Dog" : Vector3(-0.367 , 4.535 , -108.97)
}
var memories : Dictionary[String , Node3D]

func _ready() -> void :
	memories = {
		"Bin" : bin_memory ,
		"Draw" : draw_memory ,
		"Dog" : dog_memory
	}
	# Pour les tests , ligne à supprimer quand le rêve sera complet :
	#MemorySystem.set_memory_state("theater_memory_choose" , "Dog")
	set_choosen_memory()
	delete_unseen_memories()
	print(player.global_position)
	player_direction_arrow.hide()
	everything_is_fine.hide()
	new_day_text.hide()
	start_dream_ambiance()
	animation_player.play("Fading_out")
	cameras_management()
	is_dream_tutorial()
	player.stucked = true
	player_direction_arrow.show()
	await get_tree().create_timer(5.0).timeout
	play_memory()
	await memories_scenes_player.animation_finished
	end_dream()
	return

func set_choosen_memory() -> void :
	var memory_choose : String = MemorySystem.get_memory_state("theater_memory_choose")
	main_camera.global_position = main_camera_starting_positions.get(
		memory_choose
	)
	player.global_position = player_starting_positions.get(
		memory_choose
	)
	narrator_text_mesh.global_position = narrator_text_mesh_positions.get(
		memory_choose
	)
	return

func delete_unseen_memories() -> void :
	for memory_map in memories :
		if memory_map != MemorySystem.get_memory_state("theater_memory_choose") :
			var memory_to_be_deleted : Node3D = memories[memory_map]
			memory_to_be_deleted.call_deferred("queue_free")
	return

func play_memory() -> void :
	memories_scenes_player.play(MemorySystem.get_memory_state("theater_memory_choose"))
	return

func talk_narrator(text : String) -> void :
	var txt : String = ""
	for lettre in text :
		txt += lettre
		narrator_text_mesh.mesh.set("text" , txt)
		if text_sfx_player.playing :
			text_sfx_player.stop()
		text_sfx_player.play()
		await get_tree().create_timer(0.1).timeout
	return

func end_dream() -> void :
	memories_scenes_player.play("dream_end")
	await memories_scenes_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/maps/dreams/acceptation_dialog/acceptation_scene.tscn")
