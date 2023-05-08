extends CharacterBody3D;
class_name Pawn;

#############################################################
# This class holds information and functions common to all  #
# pawn types.  This can be extended to create characters,   #
# enemies, interactive props, etc.  Anything that you might #
# want a player to control                                  #
#############################################################

#Character "Stats" and information
@export var _characterMovementSpeed:int = 5;
@export var _baseColor:Color = Color(0,0,0);
@export var _startingLocation:Vector3i = Vector3i(0,0,0);

@onready var _owningGameboard:GridMap = $"../GridMap";

#Creates a dynamic material unique to each instance
var _dynamicMaterial:StandardMaterial3D = StandardMaterial3D.new();
var _isMoving:bool = false;

func _ready():
	_dynamicMaterial.albedo_color = _baseColor;
	$MeshInstance3D.set_surface_override_material(0, _dynamicMaterial);

func getCharacterSpeed():
	return _characterMovementSpeed;

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
