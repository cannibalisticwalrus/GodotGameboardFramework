extends Node3D

###########################################################
# This class holds information about the current gamemode #
# and custom constants that may be used in multiple,      #
# other classes                                           #
###########################################################

var gameMode:int = 1; #Gamemode 0 - Level Designer; Gamemode 1 - Game Master; Gamemode 2 - Player
var debugMode:int = 1; #0->OFF:1->LightDebugging:2->HeavyDebugging
	
func getGameMode():
	return gameMode;

func getDebugMode():
	return debugMode;
