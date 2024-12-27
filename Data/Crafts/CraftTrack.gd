extends Resource

class_name CraftTrack
@export var TrackName = "DEFAULT"
@export var Crafts : Array[CraftResource]
@export var bUnlockedByDefault = false

func CraftCompleted(craft : CraftResource):
	Progression.SetEntitlement(TrackName + craft.CraftID, 1)
	
func GetNextCraft():
	for craft in Crafts:
		if Progression.HasEntitlement(TrackName + craft.CraftID) == false:
			return craft
	return null

func IsUnlocked():
	return Progression.HasEntitlement(TrackName)
