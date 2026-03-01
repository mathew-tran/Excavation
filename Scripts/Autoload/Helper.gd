extends Node

@onready var PickupClass = preload("res://Prefabs/Pickup.tscn")
@onready var PopupText = preload("res://Prefabs/PopupText.tscn")

func SpawnText(text, pos):
	var instance = PopupText.instantiate()
	instance.text = text
	instance.global_position = pos
	Finder.GetFXGroup().add_child(instance)
	
func SpawnPickup(item : ItemData, pos):
	var instance = PickupClass.instantiate()
	instance.ItemType = item
	instance.global_position = pos
	Finder.GetFXGroup().add_child(instance)
