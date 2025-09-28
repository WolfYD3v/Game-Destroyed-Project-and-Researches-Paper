extends MeshInstance3D
class_name Students

@onready var students : Students = $"."
@onready var noise_player : AudioStreamPlayer3D = $NoisePlayer

@export_range(1 , 8) var students_number : int = 1

const STUDENTS = preload("res://scenes/entities/students/students.tscn")

var student_position : Vector3 = Vector3.ZERO
var sprites : Array[String] = [
	"res://assets/sprites/students_sprites/student_1.png" ,
	"res://assets/sprites/students_sprites/student_2.png" ,
	"res://assets/sprites/students_sprites/student_3.png" ,
	"res://assets/sprites/students_sprites/student_4.png"
]
var students_sounds : Array[String] = [
	"res://assets/sounds/students_sounds/students_voice_1.mp3" ,
	"res://assets/sounds/students_sounds/students_voice_2.mp3" ,
	"res://assets/sounds/students_sounds/students_voice_3.mp3" ,
	"res://assets/sounds/students_sounds/students_voice_4.mp3" ,
	"res://assets/sounds/students_sounds/students_voice_5.mp3"
]

func _ready() -> void :
	student_position = global_position
	play_sound()
	create_students()
	return

func set_student_sprite(student_mesh : MeshInstance3D) -> void :
	var new_sprite = load(sprites.pick_random())
	# Change the sprite :
	var material = student_mesh.mesh.surface_get_material(0).duplicate()
	material.set("albedo_texture" , new_sprite)
	student_mesh.mesh = QuadMesh.new()
	student_mesh.mesh.set("size" , Vector2(4.0 , 8.5))
	student_mesh.mesh.surface_set_material(0 , material)
	return

func create_students() -> void :
	if students_number <= 1 :
		set_student_sprite(students)
		return
	for loop in range(students_number - 1) :
		var student : Students = STUDENTS.instantiate()
		set_student_sprite(student)
		add_child(student)
		student_position.x += 5
		student.global_position = student_position
	return

func play_sound() -> void :
	noise_player.stream = load(students_sounds.pick_random())
	noise_player.play()
	await noise_player.finished
	play_sound()
	return
