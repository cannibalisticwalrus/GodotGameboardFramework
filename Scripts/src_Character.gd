extends CharacterBody3D

#Character Stats from Pathfinder
const pfSPEED:int = 25;

#Variables for functionality
var canMove:bool = true;
var currentGridLocation:Vector3i;

func _setNextGridLocation(newGridLocation:Vector3i):
	currentGridLocation = newGridLocation;
#	print("Character - 01: Location updated.  The character is now at ", currentGridLocation, " on the GridMap."); #DEBUGGING
	return;
	
func _updatePlayerLocation(targetPlayerLocation:Vector3):
	self.global_position = targetPlayerLocation;
	print("Character - 01: Position updated.  The character is now at ", self.global_position, " in world space."); #DEBUGGING
	
func _process(delta):
	_setNextGridLocation(Vector3i(0,0,0));
	_updatePlayerLocation(Vector3(0,0,0));
