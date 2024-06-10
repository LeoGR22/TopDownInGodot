extends Node3D

@onready var anim = $AnimationPlayer
var is_shooting : bool = false

var bullet = preload("res://Scenes/bullet.tscn")
var bullet_speed = 30
@onready var gun = $"."


@onready var sounds = [$Sound1, $Sound2, $Sound3]


func _physics_process(delta):
	if Input.is_action_just_pressed("Fire"):
		if !is_shooting:
			anim.play("fire")
			shoot()
			is_shooting = true
			await anim.animation_finished
			is_shooting = false
	else:
		if not is_shooting:
			anim.play("idle")

func shoot():
	var new_bullet = bullet.instantiate()
	get_tree().current_scene.add_child(new_bullet)
	new_bullet.global_rotation = global_rotation
	_randomizeSound()
	new_bullet.global_transform.origin = $blasterC/Muzzle.global_transform.origin
	
func _randomizeSound():
	var select_sound = sounds[randi() % sounds.size()] as AudioStreamPlayer3D
	select_sound.play()
