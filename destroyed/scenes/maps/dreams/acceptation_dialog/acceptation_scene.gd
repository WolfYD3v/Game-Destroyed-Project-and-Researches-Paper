extends Node3D

@onready var text_mesh : MeshInstance3D = $TextMesh
@onready var camera_3d : Camera3D = $Camera3D
@onready var text_sfx_player : AudioStreamPlayer3D = $TextSFXPlayer
@onready var bulling_memories : MeshInstance3D = $BullingMemories
@onready var punch_button : Button = $CanvasLayer/ButtonPunch
@onready var music_player : AudioStreamPlayer = $MusicPlayer
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var player_label : Label = $CanvasLayer/PlayerLabel
@onready var change_memory_sfx_player : AudioStreamPlayer3D = $ChangeMemorySFXPlayer
@onready var cube : Cube = $PlayerWakeUp/Cube
@onready var accept_label : Label = $CanvasLayer/ACCEPTLabel

var bulling_events : Array[String] = [
	"res://assets/textures/Bin.png" ,
	"res://assets/textures/dog.png" ,
	"res://assets/textures/pile_of_draws.png" ,
	"res://assets/textures/splashed.png" ,
	"res://assets/textures/april_fish_fool.png" ,
	"res://assets/textures/attacked.png" ,
	"res://assets/textures/more.png"
]
var can_change_textures : bool = true

func _ready() -> void :
	bulling_memories.hide()
	punch_button.hide()
	player_label.hide()
	accept_label.hide()
	await get_tree().create_timer(3.5).timeout
	scene_events()
	return

func scene_events() -> void :
	set_text("""I am your acceptance ,""")
	await get_tree().create_timer(3.5).timeout
	set_text("""
	your past is the reason
	why you are how you are
	now ."""
	)
	await get_tree().create_timer(8.5).timeout
	set_text("""
	Yes , all the past events
	you've seen needs to be
	accepted ."""
	)
	await get_tree().create_timer(8.5).timeout
	set_text("""Even theses events :""")
	await get_tree().create_timer(2.5).timeout
	show_all_bulling_events()
	await get_tree().create_timer(0.3 * bulling_events.size() + 0.5).timeout
	set_text("""
	You are the only
	responsible of them ."""
	)
	await get_tree().create_timer(6.5).timeout
	set_text("""
	Look at you ,
	inferior ,
	a looser ,
	docile ,"""
	)
	await get_tree().create_timer(7.5).timeout
	set_text("""
	your wish of totaly
	deny your past is just 
	stupid ."""
	)
	await get_tree().create_timer(7.5).timeout
	set_text("""You are stupid .""")
	await get_tree().create_timer(2.5).timeout
	set_text("""
	I understand why
	he wanted to tourment
	you since your
	childhood ."""
	)
	await get_tree().create_timer(9.5).timeout
	set_text("""
	Don't blame me for being
	rude at you ,
	this is what you are thinking
	of you now ."""
	)
	await get_tree().create_timer(10.5).timeout
	set_text("""
	I only am a part of you ,
	you know ."""
	)
	await get_tree().create_timer(6.0).timeout
	set_text("""
	Don't be angry ,
	don't try to punch you dude ."""
	)
	await get_tree().create_timer(7.0).timeout
	set_text("""I know you hate you .""")
	await get_tree().create_timer(2.5).timeout
	set_text("""
	But destroying his mind will
	not help you , it will dig a
	deaper hôle under yor feeT ."""
	)
	await get_tree().create_timer(16.0).timeout
	set_text("""
	Which will end pretty ba
	aaaaaaaaaaaaaaaaaaaaaaaa
	aaaaaadAdaddDTauidgbziud
	cekj,elc,oejvoejv,pejevv
	eikvbnekvnpsj,b^dsvk
	d
	svlsdjvpkv
	$kv
	dvl
	sd$vkse$
	^jf
	e^qjfz
	$q^fjqz$
	fk
	e=gkzqg$kscns^Pj,
	ez$^ckqs^cdvp"""
	)
	await get_tree().create_timer(30.0).timeout
	show_all_bulling_events(true)
	punch_button.show()
	return

func set_text(text_input : String) -> void :
	var txt : String = ""
	for lettre in text_input :
		txt += lettre
		text_mesh.mesh.set("text" , txt)
		text_mesh.global_position = Vector3(0.0 , 0.0 , -3.4)
		if text_sfx_player.playing :
			text_sfx_player.stop()
		text_sfx_player.play()
		await get_tree().create_timer(0.1).timeout
	return

func show_all_bulling_events(looping : bool = false) -> void :
	bulling_memories.show()
	var mat = bulling_memories.mesh.surface_get_material(0)
	for event in bulling_events :
		if looping :
			accept_label.set_visible(not accept_label.visible)
		change_memory_sfx_player.stop()
		mat.set("albedo_texture" , load(event))
		bulling_memories.mesh.surface_set_material(0 , mat)
		if not can_change_textures :
			return
		change_memory_sfx_player.play()
		await get_tree().create_timer(0.20).timeout
	bulling_memories.hide()
	if looping :
		show_all_bulling_events(true)
	return

func _on_button_punch_pressed() -> void :
	punch_button.hide()
	animation_player.play("punching")
	await get_tree().create_timer(1.0).timeout
	accept_label.text = " "
	can_change_textures = false
	await animation_player.animation_finished
	accept_label.hide()
	await get_tree().create_timer(2.2).timeout
	if not GlobalSettings.copyright_enable :
		player_label.show()
		await get_tree().create_timer(5.0).timeout
		player_label.hide()
		music_player.play()
		await get_tree().create_timer(38.5).timeout
	animation_player.play("show_cube")
	return

func _on_cube_go_to_day() -> void :
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(cube.next_scene_wake_up)
	await music_player.finished
	cube.action()
	get_tree().change_scene_to_file(cube.next_scene_wake_up)
	return
