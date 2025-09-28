extends Node3D
class_name Dream

@onready var player : Player = $Player
@onready var cube : Cube = $Cube
@onready var ambiance_stream_player : AudioStreamPlayer3D = $AmbianceStreamPlayer
@onready var sfx_player : AudioStreamPlayer3D = $SFXPlayer
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var fading : ColorRect = $CanvasLayer/Fading
@onready var day_indicator : RichTextLabel = $CanvasLayer/DayIndicator
@onready var cameras : Node3D = $Cameras
@onready var main_camera : Camera3D = $Cameras/Main
@onready var tutorial_mesh : MeshInstance3D = $Map/TutorialMesh
@onready var new_day_text : RichTextLabel = $CanvasLayer/NewDayText
@onready var everything_is_fine : Button = $CanvasLayer/EverythingIsFine
@onready var player_direction_arrow : Sprite2D = $CanvasLayer/PlayerDirectionArrow

@export var tutorial_dream : bool = false
@export var ambiance_stream : AudioStream
@export var day : String
@export var hour : String

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
	return

func _input(_event : InputEvent) -> void :
	if Input.is_action_just_pressed("turn_left") : rotate_pointer(-45)
	if Input.is_action_just_pressed("turn_right") : rotate_pointer(45)
	return

func rotate_pointer(add_rotation : int) -> void :
	for loop in range(45) :
		player_direction_arrow.rotate(deg_to_rad(add_rotation/45))
		#player_direction_arrow.rotate_y(deg_to_rad(add_rotation/45))
		await get_tree().create_timer(0.01).timeout
	return

func cameras_management() -> void :
	if player.camera_management == "Dream" :
		main_camera.current = true
	if player.camera_management == "Own" :
		main_camera.current = false
	for camera in cameras.get_children() :
		if player.camera_management == "Own" :
			camera.current = false
	return

func is_dream_tutorial() -> void :
	if not tutorial_dream :
		tutorial_mesh.call_deferred("queue_free")
	else :
		animate_tutorial_mesh()
	return

func _process(_delta : float) -> void :
	if player.camera_management == "Own" :
		return
	for camera : Camera3D in cameras.get_children() :
		if camera.current :
			camera.look_at(player.global_position)
	return

func set_day_indicator() -> void :
	day_indicator.set_text(day + "\n" + hour)
	return

func start_dream_ambiance() -> void :
	if ambiance_stream :
		ambiance_stream_player.stream = ambiance_stream
	return

func _on_animation_player_animation_finished(anim_name : StringName) -> void :
	if anim_name == "Fading_out" :
		player.stucked = false
		fading.hide()
	return

func _on_cube_go_to_day() -> void:
	animation_player.play("go_to_day_map")
	return

func animate_tutorial_mesh() -> void :
	for loop in range(15) :
		tutorial_mesh.global_position.y -= 0.3
		tutorial_mesh.global_rotation.y += 0.02
		await get_tree().create_timer(0.04).timeout
	await get_tree().create_timer(0.5).timeout
	for loop in range(15) :
		tutorial_mesh.global_position.y += 0.3
		tutorial_mesh.global_rotation.y -= 0.02
		await get_tree().create_timer(0.04).timeout
	await get_tree().create_timer(0.5).timeout
	animate_tutorial_mesh()
	return


func _on_everything_is_fine_pressed() -> void :
	get_tree().change_scene_to_file(cube.next_scene_wake_up)
	return
