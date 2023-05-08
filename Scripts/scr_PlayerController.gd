extends Node3D;
class_name PlayerController;

###########################################################
# This class holds information and functions regarding    #
# the player.  This is not to be confused with the pawns  #
# the player class controlls the camera, movement and     #
# input actions.                                          #
###########################################################

var cursorLocation3d:Vector3 = (Vector3(0,0,0));
const SCROLL_SPEED = 15;
var up:bool = false;
var down:bool = false;
var right:bool = false;
var left:bool = false;

func _input(event):	
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index==MOUSE_BUTTON_WHEEL_DOWN:
				if $Camera3D.size<35:
					$Camera3D.size+=0.5;
			if event.button_index==MOUSE_BUTTON_WHEEL_UP:
				if $Camera3D.size>10:
					$Camera3D.size-=.5;
	if event.is_action_pressed("RotateLeft"):
		self.rotate(Vector3(0,1,0), PI/2);
	if event.is_action_pressed("RotateRight"):
		self.rotate(Vector3(0,1,0), -PI/2);
	if event.is_action_pressed("SelectItem"):
		$"../Selector".selectAtCurrentLocation();
		
func _process(delta):
	up=Input.is_action_pressed("Up");
	left=Input.is_action_pressed("Left");
	right=Input.is_action_pressed("Right");
	down=Input.is_action_pressed("Down");

	if up:
		self.translate(Vector3(0,0,-SCROLL_SPEED*delta));
	if down:
		self.translate(Vector3(0,0,SCROLL_SPEED*delta));
	if left:
		self.translate(Vector3(-SCROLL_SPEED*delta,0,0));
	if right:
		self.translate(Vector3(SCROLL_SPEED*delta,0,0));
		
	cursorLocation3d = _screenPointToRay();

func _screenPointToRay():
	var spaceState = get_world_3d().direct_space_state
	
	var mousePosition = get_viewport().get_mouse_position();
	var camera = $Camera3D;
	var rayOrigin = camera.project_ray_origin(mousePosition);
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePosition) * 2000;
	var rayQuery = PhysicsRayQueryParameters3D.create(rayOrigin,rayEnd);
	
	#This is where the ray cast is fired
	var rayReturnArray = spaceState.intersect_ray(rayQuery);
	
	if rayReturnArray.has("position"):
		return rayReturnArray["position"];
	return Vector3();
	
