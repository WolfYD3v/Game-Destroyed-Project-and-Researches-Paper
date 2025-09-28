extends Control

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var ok_button : Button = $OKButton
@onready var rich_text_label : RichTextLabel = $RichTextLabel

func _ready() -> void :
	rich_text_label.hide()
	ok_button.hide()
	animation_player.play("RESET")
	await get_tree().create_timer(1.0).timeout
	animation_player.play("ShowWarning")
	return

func _on_ok_button_pressed() -> void :
	ok_button.text = "I'm okay"
	await get_tree().create_timer(0.1).timeout
	ok_button.call_deferred("queue_free")
	animation_player.play("HideWarning")
	await animation_player.animation_finished
	call_deferred("queue_free")
	return
