extends Node3D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var fading : ColorRect = $MenuUI/Fading
@onready var ambiance : AudioStreamPlayer = $Ambiance
@onready var settings : Control = $MenuUI/Settings
@onready var content_warning : Control = $MenuUI/ContentWarning

func _ready() -> void :
	ambiance.play()
	fading.hide()
	settings.hide()
	content_warning.show()
	return

func _on_play_button_pressed() -> void :
	fading.show()
	animation_player.play("Fading_in")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/maps/dreams/dream1/dream1.tscn")
	return

func _on_settings_button_pressed() -> void :
	settings.show()
	return

func _on_quit_button_pressed() -> void :
	get_tree().quit()
	return 
