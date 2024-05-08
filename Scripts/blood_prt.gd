extends GPUParticles3D

@onready var blood_prt = $"."


func _spawnPart():
	blood_prt.emitting = true
	await get_tree().create_timer(2.0).timeout
	queue_free()

