extends ColorRect
class_name End

signal monolog_dialog_ended

@onready var monolog_label : Label = $MonologLabel

func _ready() -> void :
	show_monolog_text("")
	await get_tree().create_timer(1.5).timeout
	show_monolog_text("Maybe you have realized how down you are now .")
	await monolog_dialog_ended
	await get_tree().create_timer(1.0).timeout
	show_monolog_text("Get some help , or this museum will continue to get more and more creations .")
	await monolog_dialog_ended
	await get_tree().create_timer(1.0).timeout
	show_monolog_text("Or else , one day , you will do a mistake that cannot be solved .")
	await monolog_dialog_ended
	await get_tree().create_timer(5.0).timeout
	CkeckGameState.write_death()
	get_tree().quit()

func show_monolog_text(text_value : String) -> void :
	var txt : String = ""
	for lettre in text_value :
		txt += lettre
		monolog_label.text = txt
		await get_tree().create_timer(0.1).timeout
	monolog_dialog_ended.emit()
	return
