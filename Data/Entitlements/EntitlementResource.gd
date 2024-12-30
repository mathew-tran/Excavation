extends Resource

class_name EntitlementResource

@export var EntitlementID = "X"

func Give():
	Progression.SetEntitlement(EntitlementID, 1)
