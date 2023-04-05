extends CharacterBody3D

#Character Stats from Pathfinder
const pfSPEED:int = 25;
const STRENGTH:int = 16;
const DEXTERITY:int = 14;
const CONSTITUTION:int = 16;
const INTELLIGENCE:int = 19;
const WISDOM:int = 10;
const CHARISMA:int = 10;

#Variables for functionality
var canMove:bool = true;

#Necessary Methods
func _getCurrentSquare() -> Vector3i:
	var playerGridLocation:Vector3i = Vector3i(0,0,0);
	return playerGridLocation;

func _getPossibleSquareArray(currentSquare):
	var possibleMovementLocations = []
	return;

func _setPosition():
	return;





const SPEED = 5
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
