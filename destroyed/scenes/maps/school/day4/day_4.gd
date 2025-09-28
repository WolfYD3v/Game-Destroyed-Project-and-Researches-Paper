extends Day

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var girl_mesh : Girl = $Areas/Corridor/GirlMesh
@onready var sfx_player : AudioStreamPlayer3D = $SFXPlayer
@onready var toilets : Node3D = $Areas/Toilets

func _ready() -> void :
	CharactersSystem.set_char_scene(girl_mesh)
	play_dialogue()
	move_camera_head()
	await dialogues_menu.dialogue_box.dialogue_ended
	animation_player.play("walk_to_door")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	animation_player.play("start_girl_dialogue")
	await animation_player.animation_finished
	await get_tree().create_timer(3.0).timeout
	dialogues_menu.play_dialogue("LucyDialogue")
	toilets.call_deferred("queue_free")
	await dialogues_menu.dialogue_box.dialogue_ended
	animation_player.play("destroy_corridor")
	await animation_player.animation_finished
	await get_tree().create_timer(2.0).timeout
	dialogues_menu.play_dialogue("last_dialogue")
	await dialogues_menu.dialogue_box.dialogue_ended
	get_tree().change_scene_to_file(next_scene_dream)
	return

func _on_animation_player_animation_finished(anim_name : StringName) -> void :
	if anim_name == "move_camera_head" :
		move_camera_head()
	return

func move_camera_head() -> void :
	animation_player.play("move_camera_head")
	return

func play_sfx(stream : String , volume_db : float , pitch_scale : float) -> void :
	sfx_player.stream = load(stream)
	sfx_player.volume_db = volume_db
	sfx_player.pitch_scale = pitch_scale
	sfx_player.play()
	return
