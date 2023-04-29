extends Node3D

@export var spawn_scene: PackedScene
@onready var gridMap:GridMap = $"../GridMap";
@onready var player:Node3D = $"../Player";

var _isCurrentSelection:bool = false;
var currentSelectionLocation:Vector3i;
var _currentHighlightedCell:Vector3i;

func _process(delta)->void:
	if(!_isCurrentSelection):
		_updateSelectorLocation();

func _updateSelectorLocation()->void:
	if (gridMap.isLocationValid(_getGridMapCellAtCursor())):
		var localLocationAtGridMapCell = gridMap.map_to_local(_getGridMapCellAtCursor());
		var globalLocationAtGridMapCell = gridMap.to_global(localLocationAtGridMapCell);
		self.global_position = globalLocationAtGridMapCell;
		_currentHighlightedCell = _getGridMapCellAtCursor();

func _getGridMapCellAtCursor() -> Vector3i:
	if(gridMap.get_cell_item(gridMap.local_to_map(player.cursorLocation3d)) > 0):
		return gridMap.local_to_map(player.cursorLocation3d);
	else:
		var gridmapcell =  gridMap.local_to_map(player.cursorLocation3d);
		gridmapcell.y-=1;
		return gridmapcell;

func selectAtCurrentLocation()->void:
	#If there is no current selection...
	if(!_isCurrentSelection):
		#Save the current highlightedCell into currentSelectedCell
		currentSelectionLocation = _currentHighlightedCell;
		#Set currentSelection to true
		_isCurrentSelection = true;
		#If the thing at that location a character...
		if(gridMap.isGridCellOccupiedAtLocation(currentSelectionLocation)):
			displayPawnAccessableCells(gridMap.getPawnAtGridSquare(currentSelectionLocation).getCharacterSpeed(), currentSelectionLocation);
		#Be done.  We dont want to waste any more resources
		return;
		
	#If there is a current selection, unlock the cursor if user clicked off it
	if(_isCurrentSelection):
		#If there is something at the selected cell and where you clicked is in movement range
		if(gridMap.isGridCellOccupiedAtLocation(currentSelectionLocation)&&
		_getGridMapCellAtCursor() in gridMap.getGridCellsInRange(gridMap.getPawnAtGridSquare(currentSelectionLocation).getCharacterSpeed(), currentSelectionLocation)):
			#Move the selected pawn
			gridMap.updatePawnLocation(currentSelectionLocation, _getGridMapCellAtCursor());
		
		#If the Cursor is on a different cell then clear the selection
		_isCurrentSelection = (_getGridMapCellAtCursor()==currentSelectionLocation);
		if(!_isCurrentSelection):
			_clearCursor();
		return;

func displayPawnAccessableCells(totalPawnMovement:int, pawnStartingPoint:Vector3i) -> void:
	var returnArray = gridMap.getGridCellsInRange(totalPawnMovement, pawnStartingPoint);
	for availableCell in returnArray:
		var localLocationAtGridMapCell = gridMap.map_to_local(availableCell);
		var globalLocationAtGridMapCell = gridMap.to_global(localLocationAtGridMapCell);
		spawnAtLocation(globalLocationAtGridMapCell);
	return;

func spawnAtLocation(spawnLocation:Vector3) -> void:
	var spawn := spawn_scene.instantiate() as Node3D;
	add_child(spawn);
	spawn.global_position = spawnLocation;
	return;

func _clearCursor() -> void:
	for _i in self.get_children():
		if !(_i is MeshInstance3D):
			_i.queue_free();
	return;
	
