extends RigidBody3D
class_name Barrel

@onready var mesh = $Mesh
@onready var collision = $CollisionShape3D
@onready var explosion = $Explosion
@onready var fire = $Fire
@onready var smoke = $Smoke

@onready var explosion_area = $ExplosionArea
@onready var explosion_collision = $ExplosionArea/explosionCollision


func _ready():
	explosion_area.set_deferred("monitorable",false)
	explosion_area.set_deferred("monitoring",false)
	explosion_collision.disabled = true


func _destroy():
	mesh.visible = false
	collision.set_deferred("disabled", true)
	explosion.emitting = true
	fire.emitting = true
	smoke.emitting = true
	
	explosion_area.set_deferred("monitorable", true)
	explosion_area.set_deferred("monitoring", true)
	explosion_collision.set_deferred("disabled", false)
	
	await get_tree().create_timer(1.5).timeout
	queue_free()


func _on_explosion_area_body_entered(body):
	if body is Enemy:
		body._death()
