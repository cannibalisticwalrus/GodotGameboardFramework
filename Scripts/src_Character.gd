extends CharacterBody3D
class_name playerCharacter;

#var currentGridLocation:Vector3i;
#@onready var gridMap = $"../../GridMap";
#
#func _setNextGridLocation(newGridLocation:Vector3i) -> void:
#	currentGridLocation = newGridLocation;
##	print("Character - 01: Location updated.  The character is now at ", currentGridLocation, " on the GridMap."); #DEBUGGING
#	return;
#
#func _updatePlayerLocation(targetPlayerLocation:Vector3) -> void:
#	self.global_position = targetPlayerLocation;
##	print("Character - 01: Position updated.  The character is now at ", self.global_position, " in world space."); #DEBUGGING
#	return;
#
#func _findPlayerPositionAt(gridCellLocation:Vector3i) -> Vector3:
#	var localLocationAtGridMapCell = gridMap.map_to_local(gridCellLocation);
#	var globalLocationAtGridMapCell = gridMap.to_global(localLocationAtGridMapCell);
#	return globalLocationAtGridMapCell;
#
#func _process(delta):
#	_setNextGridLocation(Vector3i(0,1,2));
#	_updatePlayerLocation(_findPlayerPositionAt(currentGridLocation));
