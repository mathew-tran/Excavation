extends Resource

class_name CraftResource

@export var Title = "CraftTitle"
@export var Description = "CraftDescription"
@export var CraftID = "000"

@export var Requirements : Array[CraftRequirement]

@export var Rewards : Array[CraftReward]

func Give():
	for reward in Rewards:
		reward.Give()
