class_name Enemy
extends CharacterBody3D

const speed = 2.0
var gravity = 400
var canMove = false

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var agent = $NavigationAgent3D
@onready var anim = $AnimationPlayer
@export var blood_part : PackedScene

var life = 3

var nextLocal
var currentPos

func _ready():
	canMove = true

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_down"):
		_take_damage()
	if canMove:
		#Move
		velocity = Vector3.ZERO
		agent.set_target_position(player.global_transform.origin)
		var next_nav_point = agent.get_next_path_position()
		velocity = (next_nav_point - global_transform.origin).normalized() * speed
		anim.play("Run")
		
		#Rotate
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		move_and_slide()
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
func _take_damage():
	if life != 0:
		life -= 1
	else:
		var blood := blood_part.instantiate() as GPUParticles3D
		Score.score += 1
		get_tree().current_scene.add_child(blood)
		blood.global_position = global_position
		blood.global_position.y += 0.5
		blood.emitting = true
		queue_free()
		


