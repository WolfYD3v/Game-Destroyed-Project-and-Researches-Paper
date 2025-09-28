extends Dream

@onready var dream_camera_1 : Camera3D = $Cameras/DreamCamera1
@onready var text_mesh_1 : MeshInstance3D = $Map/TextMesh1
@onready var text_mesh_2 : MeshInstance3D = $Map/TextMesh2
@onready var text_mesh_3 : MeshInstance3D = $Map/TextMesh3
@onready var text_mesh_4 : MeshInstance3D = $Map/TextMesh4
@onready var text_sfx_player : AudioStreamPlayer3D = $TextSFXPlayer

func _ready() -> void :
	everything_is_fine.hide()
	new_day_text.hide()
	start_dream_ambiance()
	animation_player.play("Fading_out")
	player.stucked = true
	cameras_management()
	is_dream_tutorial()
	await get_tree().create_timer(5.5).timeout
	show_text_in_dream("Do I know how to draw ?" , text_mesh_1)
	await get_tree().create_timer(6.0).timeout
	show_text_in_dream("Is it too hard to draw a cube ?" , text_mesh_2)
	return

func show_text_in_dream(text_input : String , mesh_targer : MeshInstance3D) -> void :
	var txt : String = ""
	for lettre in text_input :
		txt += lettre
		mesh_targer.mesh.set("text" , txt)
		if text_sfx_player.playing :
			text_sfx_player.stop()
		text_sfx_player.play()
		await get_tree().create_timer(0.2).timeout
	return

func _on_switch_cam_main_body_entered(_body : Node3D) -> void :
	main_camera.current = true
	dream_camera_1.current = false
	return

func _on_switch_cam_1_body_entered(_body : Node3D) -> void :
	main_camera.current = false
	dream_camera_1.current = true
	if MemorySystem.get_memory_state("day1draw_claimed") : 
		show_text_in_dream("Was this draw important for you ?" , text_mesh_3)
	else : 
		show_text_in_dream("Should it stay in the bin ?" , text_mesh_3)
	await get_tree().create_timer(3.5).timeout
	show_text_in_dream("Is he right ?" , text_mesh_4)
	return
