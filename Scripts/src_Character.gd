extends CharacterBody3D

#Character Stats from Pathfinder
const pfSPEED:int = 25;

#Variables for functionality
var canMove:bool = true;
var currentGridLocation:Vector3i;

func _updateGridLocation(newGridLocation:Vector3i):
	currentGridLocation = newGridLocation;
#	self.global_position = currentGridLocation.
	print("Character - 01: Location updated.  The character is now at ", currentGridLocation, " on the GridMap."); #DEBUGGING
	return;
	
func _process(delta):
	_updateGridLocation(Vector3i(0,0,0));
