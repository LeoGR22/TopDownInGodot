extends Node

var player_life : int = 3


var score : int = 0
var enemySpeed : float = 1.0
var enemiesKilleds : int = 0
var timeOfSpawnEnemies : float = 10

var scene = preload("res://Scenes/Menu.tscn")

func _backToMenu():
	score = 0
	enemySpeed = 1.0
	enemySpeed = 0
	timeOfSpawnEnemies = 10
	player_life = 3
	get_tree().change_scene_to_packed(scene)

func _setWaves():
	if enemiesKilleds >= 2:
		timeOfSpawnEnemies = 8.0
		enemySpeed = 2.0
	if enemiesKilleds >= 4:
		timeOfSpawnEnemies = 5.0
		enemySpeed = 3.0
	if enemiesKilleds >= 8:
		timeOfSpawnEnemies = 4.0
		enemySpeed = 3.5
	if enemiesKilleds >= 16:
		timeOfSpawnEnemies = 3.0
		enemySpeed = 4.5
