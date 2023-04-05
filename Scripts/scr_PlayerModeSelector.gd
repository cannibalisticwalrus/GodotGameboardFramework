extends MeshInstance3D
class_name cursor_playerMode

@onready var gridMap:GridMap = $"../../GridMap";
@onready var player:Node3D = $"..";
var isCurrentSelection:bool = false;
var currentSelectionLocation:Vector3i;

func _input(event):
	if(event.is_action_pressed("SelectItem")):
		var gridMapCellAtCursor = gridMap.local_to_map(player.cursorLocation3d);
		if(isCurrentSelection):
			isCurrentSelection = (gridMapCellAtCursor==currentSelectionLocation);
			currentSelectionLocation=gridMapCellAtCursor;
			return;
		isCurrentSelection = true;

func _process(delta):
	if(!isCurrentSelection):
		updateSelectorLocation();
	if(characterIsSelected()):
		return; #displayCharacterMovementOptions(currentSelection);

func updateSelectorLocation():
	var gridMapCellAtCursor = gridMap.local_to_map(player.cursorLocation3d);
	if (gridMap.get_cell_item(gridMapCellAtCursor)>=0):
		var localLocationAtGridMapCell = gridMap.map_to_local(gridMapCellAtCursor);
		var globalLocationAtGridMapCell = gridMap.to_global(localLocationAtGridMapCell);
		self.global_position = globalLocationAtGridMapCell;

func characterIsSelected()->bool:
	return false;

func displayCharacterMovementOptions(aPlayerCharacter):
	pass;


