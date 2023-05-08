extends GridMap;
class_name GameBoard;

################################################################
# The GameBoard Class handles all elements that a traditional  #
#  board game game board might have.  This includes            #
#  game sqaures (cells) and which pieces (pawns) are where.    #
################################################################

var _canPawnsShareLocation := false;
var _occupiedGridCells := {};

func _ready():
	for _i in self.get_children():
		addPawnAtLocation(_i, _i.getStartingLocation());
		var cellPlusY := Vector3i(_i.getStartingLocation().x, _i.getStartingLocation().y+1, _i.getStartingLocation().z);
		_i.moveCharacter(getGlobalLocationOfLocalCell(cellPlusY));
	if($"..".getGameMode()>0):
		_debugGamemapOccupiedCells();

func isGridCellOccupiedAtLocation(location:Vector3i) -> bool:
	return _occupiedGridCells.has(location);
	
func getPawnAtGridSquare(location:Vector3i) -> Pawn:
	return _occupiedGridCells.get(location);
	
func updatePawnLocation(oldLocation:Vector3i, newLocation:Vector3i)->void:
	if(!canPawnMoveToLocation(oldLocation, newLocation)):
		return;
	
	_occupiedGridCells[newLocation] = _occupiedGridCells[oldLocation];
	_occupiedGridCells.erase(oldLocation);
	var spawnCandidateSurfaceGlobalCoordinates := getGlobalLocationOfLocalCell(Vector3i(newLocation.x,newLocation.y,newLocation.z));
	spawnCandidateSurfaceGlobalCoordinates.y+=(self.cell_size.y/2);
	_occupiedGridCells[newLocation].moveCharacter(spawnCandidateSurfaceGlobalCoordinates);
	return;

func canPawnMoveToLocation(oldLocation:Vector3i, newLocation:Vector3i) -> bool:
	if(!isLocationValid(newLocation)):
		print("Gameboard: Location does not exist");
		return false;
	if !isGridCellOccupiedAtLocation(oldLocation):
		print("Gameboarhwod: There is no character at the starting location");
		return false;
	if isGridCellOccupiedAtLocation(newLocation) && !_canPawnsShareLocation:
		print("Gameboard: Something is already there");
		return false;
	return true;
	
func addPawnAtLocation(pawnToAdd:Node3D, location:Vector3i)->void:
	if(isLocationValid(location) && !isGridCellOccupiedAtLocation(location)):
		_occupiedGridCells[location] = pawnToAdd;
	return;

func isLocationValid(location:Vector3i) -> bool:
	return get_cell_item(location)>=0;

func getGridCellsInRange(distanceFromCenter:int, startingGridLocation:Vector3i)->Array:
	var toBeTestedQueue = getValidAdjacentGridCells(startingGridLocation);
	var gridCellsInRange := [];
	
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

func getGlobalLocationOfLocalCell(cell:Vector3i) -> Vector3:
	var localLocationAtGridMapCell = self.map_to_local(cell);
	var globalLocationAtGridMapCell = self.to_global(localLocationAtGridMapCell);
	
	return globalLocationAtGridMapCell;

func _debugGamemapOccupiedCells():
	print("---Gameboard---");
	print(_occupiedGridCells);
	print("---------------");
