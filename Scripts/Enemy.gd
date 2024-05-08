extends CharacterBody3D


const speed = 2.0
var gravity = 400
var canMove = false

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var agent = $NavigationAgent3D

var nextLocal
var currentPos

func _ready():
	canMove = true

func _physics_process(delta):
	if canMove:
		#Move
		velocity = Vector3.ZERO
		agent.set_target_position(player.global_transform.origin)
		var next_nav_point = agent.get_next_path_position()
		velocity = (next_nav_point - global_transform.origin).normalized() * speed
		
		#Rotate
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		move_and_slide()
