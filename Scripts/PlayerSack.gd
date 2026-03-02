extends Sprite2D


func _ready() -> void:
	GiveItemsToGlobalChest()
	
func GiveItemsToGlobalChest():
	var data = Finder.GetPlayerInventory().Data
	for key in data.keys():
		pass
