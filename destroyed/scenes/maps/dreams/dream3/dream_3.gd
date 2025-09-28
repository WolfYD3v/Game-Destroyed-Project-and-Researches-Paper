extends Dream

@onready var open_fence : Area3D = $Events/open_fence
@onready var dream_camera_1 : Camera3D = $Cameras/DreamCamera1
@onready var dream_camera_2 : Camera3D = $Cameras/DreamCamera2
@onready var dream_camera_3 : Camera3D = $Cameras/DreamCamera3
@onready var dream_camera_4 : Camera3D = $Cameras/DreamCamera4
@onready var dream_camera_5 : Camera3D = $Cameras/DreamCamera5
@onready var fence : StaticBody3D = $Map/Fence
@onready var fence_sfx_player : AudioStreamPlayer3D = $Map/FenceSFXPlayer
@onready var text_sfx_player : AudioStreamPlayer3D = $TextSFXPlayer
@onready var text_mesh_1 : MeshInstance3D = $Map/TextMesh1
@onready var text_mesh_2 : MeshInstance3D = $Map/TextMesh2


func _ready() -> void :
	player_direction_arrow.hide()
	everything_is_fine.hide()
	new_day_text.hide()
	start_dream_ambiance()
	animation_player.play("Fading_out")
	cameras_management()
	is_dream_tutorial()
	player.stucked = true
	player_direction_arrow.show()
	await get_tree().create_timer(7.0).timeout
	show_text_in_dream("Nightmares , only nightmares" , text_mesh_1)
	return
#func _ready() -> void:
	#var base_childs : Array = get_children()
	#var additional_childs : Dictionary = {}
	#for node in base_childs :
		#if node.get_child_count() > 0 :
			#additional_childs[node] = node.get_children()
			#base_childs.append_array(additional_childs.get(node))
	#print(base_childs.size() , " nodes in this scene")
	#return

func set_main_camera() -> void :
	main_camera.current = true
	dream_camera_1.current = false
	return

func set_camera_1() -> void :
	dream_camera_1.current = true
	main_camera.current = false
	return

func set_camera_2() -> void :
	dream_camera_2.current = true
	dream_camera_1.current = false
	return

func set_camera_3() -> void :
	dream_camera_3.current = true
	dream_camera_2.current = false
	return

func set_camera_4() -> void :
	dream_camera_4.current = true
	dream_camera_3.current = false
	return

func set_camera_5() -> void :
	dream_camera_5.current = true
	dream_camera_4.current = false
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
	set_main_camera()
	return

func _on_switch_cam_main_bis_body_entered(_body : Node3D) -> void :
	set_main_camera()
	return

func _on_switch_cam_1_body_entered(_body : Node3D) -> void :
	set_camera_1()
	return

func _on_switch_cam_2_body_entered(_body : Node3D) -> void :
	set_camera_2()
	return

func _on_switch_cam_2_bis_body_entered(_body : Node3D) -> void :
	set_camera_2()
	return

func _on_switch_cam_3_body_entered(_body : Node3D) -> void :
	set_camera_3()
	return

func _on_switch_cam_4_body_entered(_body : Node3D) -> void :
	set_camera_4()
	return

func _on_switch_cam_3_bis_body_entered(_body : Node3D) -> void :
	set_camera_3()
	return

func _on_switch_cam_4_bis_body_entered(_body : Node3D) -> void :
	set_camera_4()
	return

func _on_switch_cam_5_body_entered(_body : Node3D) -> void :
	set_camera_5()
	return


func _on_open_fence_body_entered(_body : Node3D) -> void :
	show_text_in_dream("Why does he ALWAYS talk about them !" , text_mesh_2)
	fence_sfx_player.play()
	for loop in range(30) :
		fence.global_position.y += 1
		await get_tree().create_timer(0.1).timeout
	open_fence.call_deferred("queue_free")
	return
