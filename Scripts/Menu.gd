extends Node3D

var scene = load("res://Scenes/Word.tscn")

func _process(delta):
	if Input.is_action_just_pressed("Enter"):
		_onSwitchScene()

func _onSwitchScene():
	get_tree().change_scene_to_packed(scene)

