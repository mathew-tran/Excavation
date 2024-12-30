extends Resource

class_name CraftRequirement

@export var MaterialType : MaterialResource
@export var MaterialAmount = 1

func DoesMeetRequirement():
	return Finder.GetInventory().HasItem(MaterialType, MaterialAmount)
