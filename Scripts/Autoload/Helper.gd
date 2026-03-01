extends Node

@onready var PickupClass = preload("res://Prefabs/Pickup.tscn")

func SpawnPickup(item : ItemData, pos):
	var instance = PickupClass.instantiate()
	instance.ItemType = item
	instance.global_position = pos
	Finder.GetFXGroup().add_child(instance)
