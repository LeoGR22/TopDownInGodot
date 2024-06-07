extends Node3D

@onready var spawn_points = [$Spawn1, $Spawn2, $Spawn3, $Spawn4]


var barrel = preload("res://Scenes/barrel.tscn")

func _ready():
	randomize()
	_spawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _spawn():
	var new_barrel = barrel.instantiate()
	var random_spawn_point = spawn_points[randi() % spawn_points.size()]
	new_barrel.global_transform.origin = random_spawn_point.global_transform.origin
	add_child(new_barrel)
	await get_tree().create_timer(15).timeout
	_spawn()
	
