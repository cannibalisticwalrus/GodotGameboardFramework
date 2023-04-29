extends CharacterBody3D
class_name playerCharacter;

@export var _characterMovementSpeed:int = 25;
@export var _baseColor:Color = Color(0,0,0);
@export var _startingLocation:Vector3i = Vector3i(0,0,0);

@onready var _owningGameboard:GridMap = $"../GridMap";

var _dynamicMaterial:StandardMaterial3D = StandardMaterial3D.new();
var _isMoving:bool = false;

func _ready():
	_dynamicMaterial.albedo_color = _baseColor;
	$MeshInstance3D.set_surface_override_material(0, _dynamicMaterial);

func getCharacterSpeed():
	return _characterMovementSpeed/5;

func moveCharacter(newCharacterLocation: Vector3)->void:
	#Start moving character
	_isMoving = true;
	#Move character
	global_position=newCharacterLocation;
	#End moving character
	_isMoving = false;
	return;
	
func getStartingLocation() -> Vector3i:
	return _startingLocation;
