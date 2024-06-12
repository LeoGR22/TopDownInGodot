class_name Enemy
extends CharacterBody3D

var gravity = 400
var canMove = false

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var agent = $NavigationAgent3D
@onready var anim = $AnimationPlayer
@export var blood_part : PackedScene

var life = 3
var death : bool = false

var nextLocal
var currentPos

@onready var splash_sounds = [$Sounds/Splash1, $Sounds/Splash2, $Sounds/Splash3]
@onready var damage_sounds = [$Sounds/DamageSound1, $Sounds/DamageSound2]
@onready var dead_sound = $Sounds/DeadSound

@onready var collision_shape_3d = $CollisionShape3D
@onready var cube = $Armature/Skeleton3D/Cube
@onready var area_3d = $Area3D


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
		velocity = (next_nav_point - global_transform.origin).normalized() * Manager.enemySpeed
		anim.play("Run")
		
		#Rotate
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		move_and_slide()
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
		
func _take_damage():
	if life != 0:
		life -= 1
		canMove = false
		_randomizeSound()
		await get_tree().create_timer(0.2).timeout
		canMove = true
	else:
		get_tree().create_timer(1.0).timeout
		_death()
		

func _death():
	death = true
	dead_sound.play()
	_randomizeSplashSounds()
	var blood := blood_part.instantiate() as GPUParticles3D
	Manager.score += 1
	get_tree().current_scene.add_child(blood)
	blood.global_position = global_position
	blood.global_position.y += 0.5
	blood.emitting = true
	
	Manager.enemiesKilleds += 1
	Manager._setWaves()
	
	canMove = false
	collision_shape_3d.disabled = true
	cube.visible = false
	await get_tree().create_timer(1.0).timeout
	queue_free()


func _randomizeSound():
	var select_sound = damage_sounds[randi() % damage_sounds.size()] as AudioStreamPlayer3D
	select_sound.play()
	
func _randomizeSplashSounds():
	var select_sound = splash_sounds[randi() % splash_sounds.size()] as AudioStreamPlayer3D
	select_sound.play()


