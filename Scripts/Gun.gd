extends Node3D

@onready var anim = $AnimationPlayer
var is_shooting : bool = false

var bullet = preload("res://Scenes/bullet.tscn")
var bullet_speed = 30
@onready var gun = $"."


func _physics_process(delta):
	if Input.is_action_just_pressed("Fire"):
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
	add_child(new_bullet)
	new_bullet.global_transform.origin = $blasterC/Muzzle.global_transform.origin
