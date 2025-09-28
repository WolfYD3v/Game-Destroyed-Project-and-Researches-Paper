extends Control
class_name Settings

func _ready() -> void :
	return

func _on_close_button_pressed() -> void :
	hide()
	return

func _on_enable_copyright_check_button_pressed() -> void :
	GlobalSettings.copyright_enable = not(GlobalSettings.copyright_enable)
	return
