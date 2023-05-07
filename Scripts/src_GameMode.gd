extends Node3D;
class_name GameMode;

###########################################################
# This class holds information about the current gamemode #
# and custom constants that may be used in multiple,      #
# other classes                                           #
###########################################################

var _gameMode:int = 1; #Gamemode 0 - Level Designer; Gamemode 1 - Game Master; Gamemode 2 - Player
var _debugMode:int = 1; #0->OFF:1->LightDebugging:2->HeavyDebugging

func getGameMode():
	return _gameMode;

func getDebugMode():
	return _debugMode;
