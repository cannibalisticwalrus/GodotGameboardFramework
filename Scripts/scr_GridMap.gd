extends GridMap

@onready var playerClass = $"../Player"
@onready var gameMode:int = 1; #0 = Edit Mode.  1 = Player Mode
var activeCellLocation: Vector3i;
var previousCellLocation: Vector3i = Vector3i(0,1000,0);
	

func setGameMode(gameMode:int):
	self.gameMode = gameMode;

func getGameMode() -> int:
	return gameMode

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
	
func _process(delta):
	if gameMode==0:
		updateGridSelector();
