extends Node

@onready var PickupClass = preload("res://Prefabs/Pickup.tscn")
@onready var PopupText = preload("res://Prefabs/PopupText.tscn")

func GetAllFilePaths(path: String) -> Array[String]:
	var file_paths: Array[String] = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		file_name = file_name.trim_suffix('.remap')
		var file_path = path + "/" + file_name
		if dir.current_is_dir():
			file_paths += GetAllFilePaths(file_path)
		else:
			file_paths.append(file_path)
		file_name = dir.get_next()
	return file_paths
	
func GetItemFromID(id):
	for item in GetAllFilePaths("res://Content/Items/"):
		var instance = load(item) as ItemData
		if instance.ItemID == id:
			return instance
	return null
	
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

func MoveToHub():
	Finder.GetPlayerInventory().SaveInventory()
	get_tree().change_scene_to_file("res://Scenes/Hub.tscn")
