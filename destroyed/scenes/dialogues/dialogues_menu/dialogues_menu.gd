extends Node3D

@onready var dialogue_box : DialogueBox = $SubViewportContainer/CanvasLayer/DialogueBox
@onready var audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer

var dialogue_part_idx : int = 0
var dialogue_proceed : bool = false

func play_dialogue(dialogue_id : String) -> void :
	dialogue_proceed = true
	dialogue_part_idx = 0
	dialogue_box.start_id = dialogue_id
	dialogue_box.show()
	dialogue_box.start()
	return

func _on_dialogue_box_option_selected(idx : int) -> void :
	if dialogue_box.start_id == "Day1Retrospective" :
		if dialogue_part_idx == 1 :
			if idx == 0 :
				MemorySystem.set_memory_state("day1draw_claimed" , true)
	return

func _on_dialogue_box_dialogue_processed(_speaker: Variant, dialogue: String, _options: Array[String]) -> void:
	dialogue_part_idx += 1
	audio_stream_player.stop()
	for loop in range(dialogue.length()) :
		audio_stream_player.play()
		await get_tree().create_timer(0.015).timeout
		audio_stream_player.stop()
	audio_stream_player.stop()
	return

func _on_dialogue_box_dialogue_signal(value : String) -> void :
	if CharactersSystem.get_char_scene() :
		CharactersSystem.get_char_scene().change_sprite(value)
	return

func _on_dialogue_box_dialogue_ended() -> void :
	dialogue_proceed = false
	return
