extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#rotate variables
@onready var camera_3d = $Camera3D
var rayOrigin = Vector3()
var rayEnd = Vector3()

@onready var anim = $AnimationPlayer



func _physics_process(delta):
	#Rotate
	var spaceState = get_world_3d().direct_space_state
	var mousePosition = get_viewport().get_mouse_position()
	rayOrigin = camera_3d.project_ray_origin(mousePosition)
	rayEnd = rayOrigin  + camera_3d.project_ray_normal(mousePosition) * 2000
	var intersection = spaceState.intersect_ray(PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd))
	
	if not intersection.is_empty():
		var pos = intersection.position
		$Armature.look_at(Vector3(pos.x, global_position.y, pos.z), Vector3(0,1,0))
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		anim.play("Idle")

	move_and_slide()

