extends Node

var memories_events : Dictionary = {
	"day1draw_claimed" : false ,
	"theater_memory_choose" : ""
}

func get_all_memories() -> Dictionary :
	return memories_events

func memory_exists(memory : String) -> bool :
	if memory in memories_events :
		return true
	return false

func get_memory_state(memory : String) -> Variant :
	if memory in memories_events :
		return memories_events[memory]
	return false

func set_memory_state(memory : String , value : Variant) -> void :
	if memory in memories_events :
		memories_events[memory] = value
	return
