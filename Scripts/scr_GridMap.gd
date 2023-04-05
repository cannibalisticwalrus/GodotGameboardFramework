extends GridMap

#VARIABLES
@onready var gameModeClass = $".."
@onready var playerClass = $"../Player"

var activeCellLocation:Vector3i;
var previousCellLocation:Vector3i = Vector3i(0,1000,0);

var occupiedSquares;
	
##OccupiedSquaresArray functions
#func getOccupiedSquares():
#	return occupiedSquares;
#func addOccupiedSquares(squareLocation:Vector3i, squareOccupiedBy):
#	var locationDictionary = {squareLocation: squareOccupiedBy}
#	occupiedSquares.append(locationDictionary);
#func removeOccupiedSquares(squareLocation:Vector3i):
#	occupiedSquares.erase(squareLocation);

#Checks to see if the selector's location can be selected
func isSelectorLocationValid(baseCellPosition:Vector3i, alternateCellPosition:Vector3i) -> bool:
	#Is BaseCell in the GridMap
	if (get_cell_item(baseCellPosition) < 0):
		return false;
	#Is BaseCell Location a Selector
	if (get_cell_item(baseCellPosition) == 3):
		return false;
	#Is BaseCell the save as the alternate cell position
	if (alternateCellPosition == baseCellPosition):
		return false;
	return true;

#Updates the current location of the gridMap selector in the Designer Mode
func updateGridSelector():
	#Gets the location of the cursor and its projection in 3d space
	var cursorPosition:Vector3 = playerClass.cursorLocation3d;
	
	#Finds the location of the cell at the the above projoction
	activeCellLocation = self.local_to_map(cursorPosition);
	
	if isSelectorLocationValid(activeCellLocation, previousCellLocation):
		return;
	
	#Get The Previous Selector Location
	var previousSelectorCellLocation: Vector3i = Vector3i(previousCellLocation.x,previousCellLocation.y,previousCellLocation.z);
	
	#Make sure the toBeDeleted Item is a Selector First
	if (self.get_cell_item(previousSelectorCellLocation) == 3):
		#Delete cursorCell
		set_cell_item(previousSelectorCellLocation,-1);
		
	#Sets the location of the potential selector
	var selectorCellLocation:Vector3i = Vector3i(activeCellLocation.x,activeCellLocation.y,activeCellLocation.z);
	
	#Sets the new previous cell location
	previousCellLocation = activeCellLocation;
	
	#Spawn selector cell 1 layer above base at cursor
	set_cell_item(selectorCellLocation,3);
	
#Tick function
func _process(delta):
	if (gameModeClass.getGameMode())==0:
		updateGridSelector();
