extends Node3D

#VARIABLES
@export var isDebugging:bool = false;
@export var cursorLocation3d:Vector3 = (Vector3(0,0,0));
const SCROLL_SPEED = 15;
var up:bool = false;
var down:bool = false;
var right:bool = false;
var left:bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):	
	#ZOOM
	if event is InputEventMouseButton:
		if event.is_pressed():
			#ZOOM IN
			if event.button_index==MOUSE_BUTTON_WHEEL_DOWN:
				if $Camera3D.size<35:
					$Camera3D.size+=0.5;
			
			#ZOOM OUT
			if event.button_index==MOUSE_BUTTON_WHEEL_UP:
				if $Camera3D.size>10:
					$Camera3D.size-=.5;
	
	#ROTATION
	if event.is_action_pressed("RotateLeft"):
		self.rotate(Vector3(0,1,0), PI/2);
				#ROTATION WITH KEYBOARD
	if event.is_action_pressed("RotateRight"):
		self.rotate(Vector3(0,1,0), -PI/2);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#HANDLING ACTIONS
	#SCROLL WITH KEYBOARD
	up=Input.is_action_pressed("Up");
	left=Input.is_action_pressed("Left");
	right=Input.is_action_pressed("Right");
	down=Input.is_action_pressed("Down");
	
	#PROCESS SCROLL
	if up:
		self.translate(Vector3(0,0,-SCROLL_SPEED*delta));
	if down:
		self.translate(Vector3(0,0,SCROLL_SPEED*delta));
	if left:
		self.translate(Vector3(-SCROLL_SPEED*delta,0,0));
	if right:
		self.translate(Vector3(SCROLL_SPEED*delta,0,0));
		
	cursorLocation3d = ScreenPointToRay();

func ScreenPointToRay():
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
	
