extends Node3D

@onready var anim = $AnimationPlayer
var is_shooting : bool = false

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
	pass
