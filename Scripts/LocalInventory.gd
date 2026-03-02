extends Node

class_name LocalInventory

enum INVENTORY_TYPE {
	LOCAL,
	GLOBAL
}

var Data = {}

signal OnInventoryUpdate 

@export var InventoryType : INVENTORY_TYPE

func _ready() -> void:
	LoadInventory()
	
	
func ReduceInventoryByPercent(amount):
	
	var itemsToRemove = 0
	var itemsInInventory = 0
	for item in Data.keys():
		itemsInInventory += Data[item]
	
	itemsToRemove = int(float(itemsInInventory) * (float(amount) / 100.0))
	if itemsInInventory > 0 and itemsToRemove <= 0:
		itemsToRemove += 1
	
	print("Removing X Items" + str(itemsToRemove))
	while itemsToRemove > 0:
		RemoveRandomItem()
		itemsToRemove -= 1
	
func RemoveRandomItem():
	var result = Data.keys().pick_random()
	while Data[result] <= 0:
		result = Data.keys().pick_random() 
		
	if Finder.GetPlayer():
		Helper.SpawnPickup(Helper.GetItemFromID(result), Finder.GetPlayer().global_position + Vector2(0, -64))
	Data[result] -= 1
	
func AddItem(item : ItemData, amount = 0, bShowPrompt = true):
	if Data.has(item.ItemID):
		Data[item.ItemID] += amount
	else:
		Data[item.ItemID] = amount
		
		
	var str = ""
	if bShowPrompt:
		if amount > 0:
			str = "+ "
			str += str(amount)

			str += " " + item.ItemName + " "
			str += "(" + str(Data[item.ItemID]) + ")"
			var spawnTarget = Finder.GetPlayer()
			if spawnTarget == null:
				spawnTarget = Finder.GetGlobalChest()			
			Helper.SpawnText(str, spawnTarget.global_position)
	OnInventoryUpdate.emit()
	return str

func Clear():
	Data.clear()
	SaveInventory()
	
func RemoveItem(item:  ItemData, amount = 1, bShowPrompt = false):
	if Data.has(item.ItemID):
		Data[item.ItemID] -= amount
		if bShowPrompt:
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
	
func GetInventoryName():
	if InventoryType == INVENTORY_TYPE.GLOBAL:
		return "Player-Global-Inventory"
	else:
		return "Player-Local-Inventory"
		
func SaveInventory():
	SaveManager.UpdateKey(GetInventoryName(), Data)
		
func LoadInventory():
	Data.clear()
	var data = SaveManager.GetKeyValue(GetInventoryName())
	if data:
		Data = data
			
			
