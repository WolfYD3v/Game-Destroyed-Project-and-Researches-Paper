extends Node

var SAVE_PATH : String = "res://"
var json_content : Dictionary = {
	"player dead" : true
}

func _ready() -> void :
	if is_player_dead() :
		await get_tree().create_timer(7.0).timeout
		OS.alert("ERROR | Scene 'player.tscn' cannot be found" , "Destroyed")
		OS.alert("ERROR | Script 'player.gd' cannot be found" , "Destroyed")
		OS.crash("")
	return

func is_player_dead() -> bool :
	var _file = FileAccess.open(SAVE_PATH + "game_state" + ".json" , FileAccess.READ)
	if not _file :
		_file.close()
		push_error("Fail to ckeck if the player is dead")
		return false
	var content = _file.get_as_text()
	if content.contains("true") :
		return true
	return false

func write_death() -> bool :
	var _error : bool = false
	# remove older save
	_error = DirAccess.remove_absolute(SAVE_PATH + "game_state" + ".json")
	if _error :
		push_error("Fail to erase trace of exsitance of the player")
		return true
	
	# create new save
	var _file = FileAccess.open(SAVE_PATH + "game_state" + ".json", FileAccess.WRITE)
	if _file == null :
		push_error("Fail to write player's death")
		return true
	_file.store_string(JSON.stringify(json_content , "\t"))
	_file.close()
	return false
