extends GridMap
class_name GameBoard;

var occupiedGridCells := {};
var gridCellsInRange:Array;

func getOccupiedGridCells()->Dictionary:
	return occupiedGridCells;

func getGridCellsInRange(distanceFromCenter:int, startingGridLocation:Vector3i, offLimitsArray:Array)->Array:
	return [startingGridLocation, Vector3i(startingGridLocation.x+1,startingGridLocation.y,startingGridLocation.z)];
