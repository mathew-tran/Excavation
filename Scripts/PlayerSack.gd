extends Sprite2D

class_name PlayerSack

signal OnSackCompleted


@onready var PickupClass = preload("res://Prefabs/Pickup.tscn")

func _ready() -> void:
	await get_tree().create_timer(.1).timeout
	GiveItemsToGlobalChest()
	
func GiveItemsToGlobalChest():
	print("Give items to global chest")
	var data = Finder.GetPlayerInventory().Data
	var globalChest = Finder.GetGlobalChest()
	var hasItems = false
	for key in data.keys():
		
		var waitTime = .5
		print(key)
		var itemType = Helper.GetItemFromID(key)
		for x in range(0, data[key]):
			$AnimationPlayer.stop()
			$AnimationPlayer.play("loseItem")
			print("spawn")
			var instance = PickupClass.instantiate() as Pickup
			instance.ItemType = itemType
			Finder.GetFXGroup().add_child(instance)
			instance.Target = globalChest
			instance.Speed *= 2
			instance.MoveTowardsTarget()
			instance.global_position = global_position
			await get_tree().create_timer(waitTime).timeout
			waitTime *= .75
			hasItems = true
			
	if hasItems:
		await get_tree().create_timer(1.0).timeout
	Finder.GetPlayerInventory().Clear()
	Finder.GetGlobalInventory().SaveInventory()
	SaveManager.Save()
	OnSackCompleted.emit()
			
