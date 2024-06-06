class_name Spawner
extends Node3D

@onready var spawn_points = [$Spawn1, $Spawn2, $Spawn3, $Spawn4]


var enemy = preload("res://Scenes/enemy.tscn")
var spawned : bool = false

func _ready():
	randomize()
	_spawn_enemy()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _spawn_enemy():
	var new_enemy = enemy.instantiate()
	var random_spawn_point = spawn_points[randi() % spawn_points.size()]
	new_enemy.global_transform.origin = random_spawn_point.global_transform.origin
	add_child(new_enemy)
	await get_tree().create_timer(Manager.timeOfSpawnEnemies).timeout
	_spawn_enemy()
	

