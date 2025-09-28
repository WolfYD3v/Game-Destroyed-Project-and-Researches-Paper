extends Day

@onready var player : Camera3D = $Camera3D
@onready var moving_timer : Timer = $Camera3D/MovingTimer
@onready var world_environment : WorldEnvironment = $WorldEnvironment
@onready var ray_cast_3d : RayCast3D = $Camera3D/RayCast3D
@onready var wind_sfx_player : AudioStreamPlayer3D = $WindSFXPlayer
@onready var ambiance_player : AudioStreamPlayer3D = $AmbiancePlayer
@onready var walk_sfx_player1 : AudioStreamPlayer3D = $Camera3D/WalkSFXPlayer1
@onready var walk_sfx_player2 : AudioStreamPlayer3D = $Camera3D/WalkSFXPlayer2

func _ready() -> void :
	wind_sfx_player.play()
	ambiance_player.play()
	play_dialogue()
	await get_tree().create_timer(1.5).timeout
	return

func _input(_event: InputEvent) -> void :
	if dialogues_menu.dialogue_proceed or not moving_timer.is_stopped() :
		return
	if Input.is_key_pressed(KEY_UP) :
		walk_player()
	if Input.is_key_pressed(KEY_LEFT) :
		rotate_player(45)
	if Input.is_key_pressed(KEY_RIGHT) :
		rotate_player(-45)
	return

func walk_player() -> void :
	if ray_cast_3d.is_colliding() :
		return
	moving_timer.start(0.4)
	play_walk_sounds()
	for loop in range(15) :
		world_environment.environment.background_energy_multiplier -= 0.09/15
		world_environment.environment.ambient_light_energy -= 0.9/15
		player.global_position.z += 15/15
		$OmniLight3D.global_position.z += 15/15
		if player.fov + 3 < 178 :
			player.fov += 3/15
		else :
			player.fov = 178
		await get_tree().create_timer(0.05).timeout
	return

func play_walk_sounds() -> void :
	walk_sfx_player1.play()
	await walk_sfx_player1.finished
	walk_sfx_player2.play()
	return

func rotate_player(rotation_deg : int) -> void :
	moving_timer.start(0.4)
	for loop in range(15) :
		player.rotate_y(deg_to_rad(rotation_deg/15))
		await get_tree().create_timer(0.05).timeout
	return

func _on_school_corridor_theater_visible() -> void :
	wind_sfx_player.stop()
	ambiance_player.stop()
	var reduce_fov : int = player.fov - 75
	for loop in range(20) :
		player.fov -= reduce_fov/20
		await get_tree().create_timer(0.05).timeout
	await get_tree().create_timer(3.5).timeout
	dialogues_menu.play_dialogue("TheaterScene")
	await get_tree().create_timer(5.5).timeout
	return

func _on_school_corridor_item_clicked() -> void :
	get_tree().change_scene_to_file(next_scene_dream)
	return
