extends MeshInstance3D
class_name cursor_playerMode

#VARIABLES
var isVisible:bool = true;
var moveToOffset:Vector3;
var previousCursorGridPosition:Vector3i;
@onready var gridMap:GridMap = $"../../GridMap";
var isSelected:bool = false;

#Update the Location of the Selector while on player mode
func updateSelectorLocation():
	var cursorPosition:Vector3 = $"..".cursorLocation3d;
	var currentSelectorPosition:Vector3
	var gridMapCellAtCursor = gridMap.local_to_map(cursorPosition);
	if (gridMap.get_cell_item(gridMapCellAtCursor)>=0):
		var localLocationAtGridMapCell = gridMap.map_to_local(gridMapCellAtCursor);
		var globalLocationAtGridMapCell = gridMap.to_global(localLocationAtGridMapCell);
		self.global_position = globalLocationAtGridMapCell;

#Tick Function
func _process(delta):
	updateSelectorLocation();
