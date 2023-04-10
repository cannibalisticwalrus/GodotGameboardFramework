extends MeshInstance3D

@export var spawn_scene: PackedScene
@onready var gridMap:GridMap = $"../../GridMap";
@onready var player:Node3D = $"../../Player";
@onready var character:playerCharacter=$"../../PlayerCharacter";
@onready var parent:Node3D = $"..";

var isCurrentSelection:bool = false;
var currentSelectionLocation:Vector3i;

func selectAtCurrentLocation()->void:
	var gridMapCellAtCursor = gridMap.local_to_map(player.cursorLocation3d);
	
	#If there is a current selection, unlock the cursor if user clicked off it
	if(isCurrentSelection):
		isCurrentSelection = (gridMapCellAtCursor==currentSelectionLocation);
		destroyChildren();
		return;

	#If the cell at the cursor is not of type empty, select the cell, lock the cursor, get the cells in range of the cursor, print them (To Console = Debug/To Screen = Default)
	if (gridMap.get_cell_item(gridMapCellAtCursor)>=0):
		isCurrentSelection = true;
		currentSelectionLocation=gridMapCellAtCursor;
		var returnArray = []
		returnArray = gridMap.getGridCellsInRange(5, gridMapCellAtCursor, returnArray);
		print(returnArray);
		for availableCell in returnArray:
			print("Creating cube at: ", availableCell);
			var localLocationAtGridMapCell = gridMap.map_to_local(availableCell);
			var globalLocationAtGridMapCell = gridMap.to_global(localLocationAtGridMapCell);
			spawnAtLocation(globalLocationAtGridMapCell);
	return;

func spawnAtLocation(spawnLocation:Vector3) -> void:
	var spawn := spawn_scene.instantiate() as Node3D;
	add_child(spawn);
	spawn.global_position = spawnLocation;
	return;

func destroyChildren() -> void:
	for _i in self.get_children():
		_i.queue_free();
	return;
	
func _process(delta)->void:
	if(!isCurrentSelection):
		updateSelectorLocation();

func updateSelectorLocation()->void:
	var gridMapCellAtCursor = gridMap.local_to_map(player.cursorLocation3d);
	if (gridMap.get_cell_item(gridMapCellAtCursor)>=0):
		var localLocationAtGridMapCell = gridMap.map_to_local(gridMapCellAtCursor);
		var globalLocationAtGridMapCell = gridMap.to_global(localLocationAtGridMapCell);
		self.global_position = globalLocationAtGridMapCell;
