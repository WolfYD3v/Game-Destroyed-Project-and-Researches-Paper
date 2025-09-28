extends Node3D

signal theater_visible
signal item_clicked

@onready var back_wall : Node3D = $Theater/BackWall
@onready var corridor : Node3D = $Corridor
@onready var theater : Node3D = $Theater
@onready var go_to_theater : Area3D = $GoToTheater
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sfx_player : AudioStreamPlayer = $SFXPlayer
@onready var bin : MeshInstance3D = $Theater/Items/Bin
@onready var draw : MeshInstance3D = $Theater/Items/Draw
@onready var dog : MeshInstance3D = $Theater/Items/Dog

var is_item_hovered : bool = false

func _ready() -> void :
	back_wall.hide()
	return

func _input(_event : InputEvent) -> void :
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and is_item_hovered :
		item_clicked.emit()
	return

func _on_go_to_theater_area_entered(_area: Area3D) -> void:
	show_theater()
	theater_visible.emit()
	return

func _on_mouse_detection_mouse_entered() -> void :
	item_hovered(bin.name)
	return

func _on_mouse_detection_mouse_exited() -> void :
	item_not_hovered()
	return

func _on_mouse_detection_1_mouse_entered() -> void :
	item_hovered(draw.name)
	return

func _on_mouse_detection_1_mouse_exited() -> void :
	item_not_hovered()
	return

func _on_mouse_detection_2_mouse_entered() -> void :
	item_hovered(dog.name)
	return

func _on_mouse_detection_2_mouse_exited() -> void :
	item_not_hovered()
	return

func item_hovered(item_hovered : String) -> void :
	MemorySystem.set_memory_state("theater_memory_choose" , item_hovered)
	is_item_hovered = true
	return

func item_not_hovered() -> void :
	MemorySystem.set_memory_state("theater_memory_choose" , "")
	is_item_hovered = false
	return

func show_theater() -> void :
	back_wall.show()
	animation_player.play("destroy_corridor")
	play_sfx("res://assets/sounds/Retro Weird Psych 18.wav" , -13.0 , 0.4)
	go_to_theater.call_deferred("queue_free")
	await animation_player.animation_finished
	corridor.call_deferred("queue_free")
	await get_tree().create_timer(5.0).timeout
	play_sfx("res://assets/sounds/dropping-rocks-5996.mp3" , 15.0 , 0.15)
	animation_player.play("show_items")
	await get_tree().create_timer(4.5).timeout
	sfx_player.stop()
	return

func play_sfx(stream : String , volume_db : float , pitch_scale : float) -> void :
	sfx_player.stream = load(stream)
	sfx_player.volume_db = volume_db
	sfx_player.pitch_scale = pitch_scale
	sfx_player.play()
	return
