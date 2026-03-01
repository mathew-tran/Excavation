extends Node

class_name LocalInventory


var Data = {}

@export var bIsPlayer = false

signal OnInventoryUpdate 


func _ready() -> void:
	LoadInventory()
	
	
func AddItem(item : ItemData, amount = 0, bShowPrompt = true):
	if Data.has(item.ItemID):
		Data[item.ItemID] += amount
	else:
		Data[item.ItemID] = amount
		
		
	var str = ""
	if bShowPrompt:
		if bIsPlayer:
			if amount > 0:
				str = "+ "
				str += str(amount)

				str += " " + item.ItemName + " "
				str += "(" + str(Data[item.ItemID]) + ")"
				Helper.SpawnText(str, Finder.GetPlayer().global_position)
	OnInventoryUpdate.emit()
	return str

func RemoveItem(item:  ItemData, amount = 1, bShowPrompt = false):
	if Data.has(item.ItemID):
		Data[item.ItemID] -= amount
		if bShowPrompt:
			if bIsPlayer:
				var str = ""
				if amount > 0:
					str = "Removed "
					str += str(amount)

					str += " " + item.ItemName + "."
					
	OnInventoryUpdate.emit()
	
func GetItem(item : ItemData):
	if Data.has(item.ItemID):
		return Data[item.ItemID]
	return 0
	
func SaveInventory():
	if bIsPlayer:
		SaveManager.UpdateKey("Player-Inventory", Data)
		
func LoadInventory():
	Data.clear()
	if bIsPlayer:
		var data = SaveManager.GetKeyValue("Player-Inventory")
		if data:
			Data = data
			
			
