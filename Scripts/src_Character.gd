extends CharacterBody3D
class_name playerCharacter;

var characterMovementSpeed:int = 25;

func getCharacterSpeed():
	return characterMovementSpeed/5;
	
func moveCharacter(newCharacterLocation: Vector3)->void:
	return;
