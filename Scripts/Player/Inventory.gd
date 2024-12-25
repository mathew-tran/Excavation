extends Node

class_name Inventory

var MaxItemAmount = 2

var Items : Array[InventorySlot]

signal AddItemAttempt
signal InventoryLoaded

var bHasBeenLoaded = false

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
				
	InventoryLoaded.emit()
	bHasBeenLoaded = true
	
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
	
func HasItem(ItemType : MaterialResource, amount):
	for item in Items:
		if item.ItemType == ItemType:
			return item.Amount >= amount
	return false
	
func GetItemAmount(ItemType : MaterialResource):
	for item in Items:
		if item.ItemType == ItemType:
			return item.Amount
	return 0
	
func GetMaxItemAmount():
	return MaxItemAmount
	
func GetItems():
	return Items

func HasFreeSlots():
	for item in Items:
		if item.ItemType == null:
			return true
	return false
	
func CanAddItem(ItemType: MaterialResource):
	if CheckItemInSlot(ItemType) != -1:
		return true
	
	if HasFreeSlots():
		return true
		
	return false
	
func CheckItemInSlot(ItemType: MaterialResource) ->int :
	for index in range(0, len(Items)):
		if Items[index].ItemType == ItemType:
			return index
	return -1
	
func AddItem(ItemType : MaterialResource, amount):
	
	var existingSlot = CheckItemInSlot(ItemType)
	if existingSlot == - 1:
		for index in range(0, len(Items)):
			if Items[index].ItemType == null:
				Items[index].ItemType = ItemType
				Items[index].Amount = amount
				Items[index].Update.emit()
				break
		
	else:
	
		Items[existingSlot].Amount += amount
		Items[existingSlot].Update.emit()
		
	AddItemAttempt.emit()	
	SaveManager.Save()
	var instance = load("res://Prefabs/UI/PickupText.tscn").instantiate()
	Finder.GetPlayer().add_child(instance)
	instance.Setup(ItemType.MaterialName)
	instance.global_position = Finder.GetPlayer().global_position

func RemoveItem(ItemType: MaterialResource, amount):
	for item in Items:
		if item.ItemType == ItemType:
			item.Amount -= amount
			if item.Amount == 0:
				item.ItemType = null
			item.Update.emit()				
			break
	AddItemAttempt.emit()
	SaveManager.Save()
