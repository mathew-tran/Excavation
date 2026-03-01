extends Node

var Data = {}

var SaveFilePath = "user://savegame1.save"

func _ready():
	Load()

	
func GetLastLoadedWorld():
	if GetHasDied() == false:
		var result = GetKeyValue("LastWorldScene")
		if result:
			return result
	else:
		var result = GetKeyValue("SAFE-LastWorldScene")
		if result:
			return result
	return 	"res://Scenes/Worlds/Brickton.tscn"
	
	
func SaveLastTown(scene):
	UpdateKey("LastTown", scene)
	
func GetLastTown():
	var result = GetKeyValue("LastTown")
	if result:
		return result
	return "res://Scenes/Worlds/Brickton.tscn"
	
func SavePlayerPosition(player):
	UpdateKey("OverworldPosition", player.global_position)
	UpdateKey("LastWorldScene", get_tree().current_scene.scene_file_path)
		
func UpdatePlayerPosition(newScene, newPosition, entryPoint):
	UpdateKey("OverworldPosition", newPosition)
	UpdateKey("LastWorldScene", newScene)
	UpdateKey("EntryPoint", entryPoint)
	
func UpdatePlayerSafePosition(newScene, newPosition, entryPoint):
	UpdateKey("SAFE-OverworldPosition", newPosition)
	UpdateKey("SAFE-LastWorldScene", newScene)
	UpdateKey("SAFE-EntryPoint", entryPoint)
	
func GetHasDied():
	var result = GetKeyValue("HasDied")
	if result:
		return result
	return false
	
func SetHasDied(bHasDied):
	UpdateKey("HasDied", bHasDied)


func ClearSafePosition():
	UpdateKey("SAFE-OverworldPosition", Vector2(0,0))
	UpdateKey("SAFE-LastWorldScene", null)
	UpdateKey("SAFE-EntryPoint", -1)
	
	
	
func Load():
	if FileAccess.file_exists(SaveFilePath):
		var file = FileAccess.open(SaveFilePath, FileAccess.READ)
		Data = file.get_var()
		print("Data loaded")
		print(Data)
		file.close()
	else:
		Data = {}
		print("No Data found")

func InstantSave():
	Save()
	
func Save():
	var file = FileAccess.open(SaveFilePath,FileAccess.WRITE)
	file.store_var(Data)
	file.close()
	
func ClearData():
	Data = {}
	Save()
	Finder.GetPlayerInventory().LoadInventory()
	
func UpdateKey(key, value):
	Data[key] = value

	
func GetKeyValue(key):
	if Data.has(key):
		return Data[key]
	return {}
	
func GetSubCategoryValue(subcategory, key):
	var result = GetKeyValue(subcategory)
	if result == {}:
		UpdateKey(subcategory, {})
	result = GetKeyValue(subcategory)
	if result.has(key):
		return result[key]
	return null
	
func SetSubCategoryValue(subcategory, key, value = true):
	var unlocks = GetKeyValue(subcategory)
	unlocks[key] = value
	Data[subcategory] = unlocks
	
func GetUnlockKeyValue(key):
	var result = GetSubCategoryValue("Unlocks", key)
	if result == null:
		return false
	return GetSubCategoryValue("Unlocks", key)
	
func SetUnlockKeyValue(key, value = true):
	SetSubCategoryValue("Unlocks", key, value)
