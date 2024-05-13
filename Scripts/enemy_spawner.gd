class_name Spawner
extends Node3D

var enemy = preload("res://Scenes/enemy.tscn")
var spawned : bool = false

func _ready():
	_spawn_enemy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _spawn_enemy():
	var new_enemy = enemy.instantiate()
	add_child(new_enemy)
	await get_tree().create_timer(1).timeout
	_spawn_enemy()
	

