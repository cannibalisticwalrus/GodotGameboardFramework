extends CharacterBody3D
class_name playerCharacter;

@export var _characterMovementSpeed:int = 25;
var _isMoving:bool = false;
@onready var _owningGameboard:GridMap = $"../GridMap";


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
