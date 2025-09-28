extends Day

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var camera : Camera3D = $Camera3D
@onready var draw : MeshInstance3D = $Draw

var tween

func _ready() -> void :
	CharactersSystem.set_char_scene(bully_mesh)
	animation_player.play("move_head")
	dialogues_menu.play_dialogue("day1communication_speak")
	await dialogues_menu.dialogue_box.dialogue_ended
	animation_player.stop()
	await get_tree().create_timer(0.7).timeout
	animation_player.play("look_up")
	await animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	play_dialogue()
	await get_tree().create_timer(1.0).timeout
	draw.call_deferred("hide")
	await dialogues_menu.dialogue_box.dialogue_ended
	animation_player.play("bully_leave")
	await animation_player.animation_finished
	animation_player.play("walk_sequence")
	await get_tree().create_timer(2.5).timeout
	dialogues_menu.play_dialogue("Day1Retrospective")
	await dialogues_menu.dialogue_box.dialogue_ended
	get_tree().change_scene_to_file(next_scene_dream)
	return

func _on_animation_player_animation_finished(anim_name : StringName) -> void :
	if anim_name == "move_head" :
		animation_player.play("move_head")
	return
