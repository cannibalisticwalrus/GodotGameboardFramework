extends MeshInstance3D

var isVisible:bool = true;
var moveToOffset:Vector3;
var previousCursorGridPosition:Vector3i;
@onready var gridMap:GridMap = $"../../GridMap";


func _ready():
	pass # Replace with function body.
	
func updateSelectorLocation():
	var cursorPosition:Vector3 = $"..".cursorLocation3d;
	var currentSelectorPosition:Vector3
	var gridMapCellAtCursor = gridMap.local_to_map(cursorPosition);
	if (gridMap.get_cell_item(gridMapCellAtCursor)>=0):
		var localLocationAtGridMapCell = gridMap.map_to_local(gridMapCellAtCursor);
		var globalLocationAtGridMapCell = gridMap.to_global(localLocationAtGridMapCell);
		self.global_position = globalLocationAtGridMapCell;

func _process(delta):
	updateSelectorLocation();
