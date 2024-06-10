extends Node3D

@onready var score = $Ui/Score
@onready var player_life = $Ui/PlayerLife
@onready var audio_stream_player = $AudioStreamPlayer


func _ready():
	pass # Replace with function body.


func _process(delta):
	score.text = "Score: " + str(Manager.score)
	player_life.text = "Life: " + str(Manager.player_life)

