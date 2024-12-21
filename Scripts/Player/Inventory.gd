extends Node

class_name Inventory

@export var MaxItemAmount = 6

var Items : Array[InventorySlot]

signal AddItemAttempt

func _ready():
	for item in range(0, MaxItemAmount):
		Items.append(InventorySlot.new())
		
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
