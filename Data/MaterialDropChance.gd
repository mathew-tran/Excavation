extends Resource

class_name MaterialDropChance

@export var MatResource : MaterialResource
@export var DropAmount = 1
@export var DropRange = 1
@export var DropChance = 10


func CanAttainDrop():
	var result = randi_range(0, 100)
	return DropChance >= result
		
func GetDrop():
	var data = {}
	data["type"] = MatResource
	data["amount"] = max(DropAmount, 1) + randi_range(0, DropRange)
	return data

# This is where we should spawn drops in a relative area as objects. then move them torwards player.
func Open(openPosition):
	if CanAttainDrop():
		var drop = GetDrop()
		for amount in range(0, drop["amount"]):
			var instance = load("res://Prefabs/DroppedMaterial.tscn").instantiate()
			
			instance.Setup(drop["type"])
			Finder.GetDropsGroup().add_child(instance)
			instance.global_position = openPosition
