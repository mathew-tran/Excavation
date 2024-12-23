extends Node

class_name Inventory

var MaxItemAmount = 12

var Items : Array[InventorySlot]

signal AddItemAttempt

func GetSaveCategory():
	return "Inventory"
	
func _ready():
	
	for item in range(0, MaxItemAmount):
		Items.append(InventorySlot.new())
		
	SaveManager.SavingData.connect(OnSavingData)
	await SaveManager.DataLoaded
	
	if SaveManager.HasData(GetSaveCategory()):
		var data = SaveManager.GetData(GetSaveCategory())
		for x in range(0, len(Items)):
			if data["Items"][x] != null:
				var materialData = Helper.GetMaterialFromID(data["Items"][x]["id"])
				Items[x].ItemType = materialData
				Items[x].Amount = data["Items"][x]["amount"]
				Items[x].Update.emit()

func OnSavingData():
	var data = {
		"SlotAmount" : MaxItemAmount,
		"Items" : GetItemData()
	}
	SaveManager.SaveData("Inventory", data)
	
func GetItemData():
	var data = {}
	for item in range(0, len(Items)):
		if Items[item].ItemType == null:
			data[item] = null
		else:
			var subData = {}
			subData["id"] = Items[item].ItemType.MaterialID
			subData["amount"] = Items[item].Amount
			data[item] = subData
	return data
	
func GetMaxItemAmount():
	return MaxItemAmount
	
func GetItems():
	return Items

func CanAddItem():
	return true
	
func AddItem(ItemType : MaterialResource, amount):
	for item in Items:
		if item.ItemType == ItemType:
			item.Amount += amount
			item.Update.emit()
			break
		elif item.ItemType == null:
			item.ItemType = ItemType
			item.Amount = amount
			item.Update.emit()
			break
	AddItemAttempt.emit()	
	SaveManager.Save()