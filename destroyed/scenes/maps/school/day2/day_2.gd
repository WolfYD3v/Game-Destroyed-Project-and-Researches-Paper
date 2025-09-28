extends Day

@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void :
	animation_player.play("idle")
	await get_tree().create_timer(0.3).timeout
	play_dialogue()
	await  dialogues_menu.dialogue_box.dialogue_ended
	await get_tree().create_timer(0.5).timeout
	animation_player.play("walk")
	await get_tree().create_timer(1.5).timeout
	dialogues_menu.play_dialogue("bulling1day2")
	await  dialogues_menu.dialogue_box.dialogue_ended
	get_tree().change_scene_to_file(next_scene_dream)
	return

func _on_animation_player_animation_finished(anim_name : StringName) -> void :
	if anim_name == "idle" :
		animation_player.play("idle")
	return
