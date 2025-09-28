extends CharacterBody3D
class_name Player

@onready var camera : Camera3D = $Camera3D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var ray_cast_1 : RayCast3D = $RayCast1
@onready var ray_cast_2 : RayCast3D = $RayCast2
@onready var direction_pointer : MeshInstance3D = $DirectionPointer
@onready var model : Node3D = $Model

@export_enum("Own" , "Dream") var camera_management : String = "Dream"

@export var speed : int
@export var stucked : bool = false :
	set(value) :
		stucked = value
		indicate_if_can_move(value)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var looking_up : bool = false
var can_move : bool = true

func _ready() -> void :
	indicate_if_can_move(stucked)
	global_position.y = 0
	if camera_management == "Dream" :
		camera.current = false
		ray_cast_1.enabled = true
		ray_cast_2.enabled = false
		model.show()
	if camera_management == "Own" :
		camera.current = true
		ray_cast_1.enabled = false
		ray_cast_2.enabled = true
		model.hide()
	return

func _input(_event: InputEvent) -> void :
	if stucked :
		return
	if can_move :
		if Input.is_action_just_pressed("walk_toward") : walk()
		if Input.is_action_just_pressed("turn_left") : rotate_player(45)
		if Input.is_action_just_pressed("turn_right") : rotate_player(-45)
	return

func rotate_player(add_rotation : int) -> void :
	for loop in range(45) :
		rotate_y(deg_to_rad(add_rotation/45))
		await get_tree().create_timer(0.01).timeout
	return

func walk() -> void :
	if ray_cast_1.is_colliding() or ray_cast_2.is_colliding() :
		return
	var angle = get_rotation().y 
	can_move = false
	set_player_sprite_on_mesh("res://assets/sprites/player_sprites/player2.png")
	for loop in range(45) :
		if camera_management == "Dream" :
			velocity = Vector3(sin(angle),0, cos(angle)) * speed / 45
		if camera_management == "Own" :
			velocity = Vector3(sin(angle),0, cos(angle)) * speed / -45
		move_and_slide()
		await get_tree().create_timer(0.01).timeout
	set_player_sprite_on_mesh("res://assets/sprites/player_sprites/player1.png")
	can_move = true
	return

func set_player_sprite_on_mesh(sprite_path : String) -> void :
	if camera_management == "Own" :
		return
	var sprite = load(sprite_path)
	var material = model.get_children()[0].mesh.surface_get_material(0).duplicate()
	material.set("albedo_texture" , sprite)
	for face in model.get_children() :
		face.mesh.surface_set_material(0 , material)
	return

func indicate_if_can_move(value : bool) -> void :
	var material = direction_pointer.mesh.surface_get_material(0).duplicate()
	if not value :
		material.set("albedo_color" , Color(0.743 , 0.394 , 0.361 , 1.000))
	else :
		material.set("albedo_color" , Color(0.422 , 0.173 , 0.124 , 1.000))
	direction_pointer.mesh.surface_set_material(0 , material)
	return
