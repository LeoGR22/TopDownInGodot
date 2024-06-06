extends Node3D

@onready var score = $Ui/Score


func _ready():
	pass # Replace with function body.


func _process(delta):
	score.text = "Score: " + str(Manager.score)

