extends Node3D

var speed = 10
var enemy_ref : Enemy

func _ready():
	await get_tree().create_timer(1).timeout
	queue_free()

func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * speed * delta)


func _on_body_entered(body):
	if body is Enemy:
		body._take_damage()
		queue_free()
		
	if body is Barrel:
		body._destroy()
		queue_free()
