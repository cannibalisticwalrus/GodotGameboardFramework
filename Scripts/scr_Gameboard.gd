extends GridMap
class_name GameBoard;

var _occupiedGridCells := {};

func isGridCellOccupiedAtLocation(location:Vector3i) -> bool:
	return _occupiedGridCells.has(location);

func updatePawnLocation(oldLocation:Vector3i, newLocation:Vector3i)->void:
	if($"..".getGameMode()>0):
		_debugGamemapOccupiedCells()
	if(!isLocationValid(newLocation)):
		print("Gameboard: Location does not exist");
		return;
	if !isGridCellOccupiedAtLocation(oldLocation):
		print("Gameboard: There is nothing at the initial location");
		return;
	if isGridCellOccupiedAtLocation(newLocation):
		print("Gameboard: Something is already there");
		return;
	_occupiedGridCells[newLocation] = _occupiedGridCells[oldLocation];
	_occupiedGridCells.erase(oldLocation);
	if($"..".getGameMode()>0):
		_debugGamemapOccupiedCells()
	return;
	
func addPawnAtLocation(pawnToAdd:Node3D, location:Vector3i)->void:
	if(isLocationValid(location) && !isGridCellOccupiedAtLocation(location)):
		_occupiedGridCells[location] = pawnToAdd;
	return;

func isLocationValid(location:Vector3i) -> bool:
	return get_cell_item(location)>=0;

func _debugGamemapOccupiedCells():
	print("---Gameboard---");
	print(_occupiedGridCells);
	print("---------------");

func getGridCellsInRange(distanceFromCenter:int, startingGridLocation:Vector3i)->Array:
	if($"../../Node3D".getDebugMode()>0):
		print("\n----Gameboard Class: getGridCellsInRange()----");
		print("Distance From Center: ", distanceFromCenter);
		print("Starting Grid Location: ", startingGridLocation);
		print("-----------------------------------------------");
	
	var toBeTestedQueue: = getValidAdjacentGridCells(startingGridLocation);
	var gridCellsInRange = [];
	
	while toBeTestedQueue.size() > 0:
		var currentCell:Vector3i = toBeTestedQueue.pop_front();
		if get_cell_item(currentCell) >= 0 && getDistanceBetweenCells(startingGridLocation, currentCell) <= distanceFromCenter:
			gridCellsInRange.append(currentCell);
			for i in getValidAdjacentGridCells(currentCell):
				if i not in gridCellsInRange && i not in toBeTestedQueue:
					toBeTestedQueue.append(i);
	
	return gridCellsInRange;
	
func getValidAdjacentGridCells(startingLocation:Vector3i)->Array:
	var adjacentGridCells := [];
	
	var xPlus1 := Vector3i(startingLocation.x+1,startingLocation.y,startingLocation.z);
	var oneUp := Vector3i(xPlus1.x, xPlus1.y+1, xPlus1.z)
	
	if get_cell_item(oneUp)>=0:
		var twoUp := Vector3i(oneUp.x, oneUp.y+1, oneUp.z)
		if !get_cell_item(twoUp)>=0:
			adjacentGridCells.append(oneUp);
	elif get_cell_item(xPlus1)>=0:
		adjacentGridCells.append(xPlus1);
	else:
		var oneDown := Vector3i(xPlus1.x, xPlus1.y-1, xPlus1.z);
		if get_cell_item(oneDown)>=0:
			adjacentGridCells.append(oneDown);
	
	var xMinus1 := Vector3i(startingLocation.x-1,startingLocation.y,startingLocation.z);
	oneUp = Vector3i(xPlus1.x, xPlus1.y+1, xPlus1.z)
	
	if get_cell_item(oneUp)>=0:
		var twoUp := Vector3i(oneUp.x, oneUp.y+1, oneUp.z)
		if !get_cell_item(twoUp)>=0:
			adjacentGridCells.append(oneUp);
	elif get_cell_item(xMinus1)>=0:
		adjacentGridCells.append(xMinus1);
	else:
		var oneDown = Vector3i(xMinus1.x, xMinus1.y-1, xMinus1.z);
		if get_cell_item(oneDown)>=0:
			adjacentGridCells.append(oneDown);
	
	var zPlus1 := Vector3i(startingLocation.x,startingLocation.y,startingLocation.z+1);
	oneUp = Vector3i(xPlus1.x, xPlus1.y+1, xPlus1.z)
	
	if get_cell_item(oneUp)>=0:
		var twoUp := Vector3i(oneUp.x, oneUp.y+1, oneUp.z)
		if !get_cell_item(twoUp)>=0:
			adjacentGridCells.append(oneUp);
	elif get_cell_item(zPlus1)>=0:
		adjacentGridCells.append(zPlus1);
	else:
		var oneDown = Vector3i(zPlus1.x, zPlus1.y-1, zPlus1.z);
		if get_cell_item(oneDown)>=0:
			adjacentGridCells.append(oneDown);
	
	var zMinus1 := Vector3i(startingLocation.x,startingLocation.y,startingLocation.z-1);
	oneUp = Vector3i(xPlus1.x, xPlus1.y+1, xPlus1.z)
	
	if get_cell_item(oneUp)>=0:
		var twoUp := Vector3i(oneUp.x, oneUp.y+1, oneUp.z)
		if !get_cell_item(twoUp)>=0:
			adjacentGridCells.append(oneUp);
	elif get_cell_item(zMinus1)>=0:
		adjacentGridCells.append(zMinus1);
	else:
		var oneDown = Vector3i(zMinus1.x, zMinus1.y-1, zMinus1.z);
		if get_cell_item(oneDown)>=0:
			adjacentGridCells.append(oneDown);
			
	return adjacentGridCells;

func getDistanceBetweenCells(gridLocation1:Vector3i, gridLocation2:Vector3i)->int:
	var distanceBetweenCells:int = 0;
	var xDistance = abs(gridLocation2.x - gridLocation1.x);
	var yDistance = abs(gridLocation2.y - gridLocation1.y);
	var zDistance = abs(gridLocation2.z - gridLocation1.z);
	distanceBetweenCells = xDistance+yDistance+zDistance;
	return distanceBetweenCells;

func _ready():
	if($"..".getGameMode()>0):
		_occupiedGridCells[Vector3i(0,0,0)] = "CHARACTER1";
		_debugGamemapOccupiedCells()
		
