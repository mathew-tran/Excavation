extends CraftReward

class_name CraftRewardEntitlement

@export var Entitlement : EntitlementResource

func Give():
	Progression.SetEntitlement(Entitlement.EntitlementID, 1)
