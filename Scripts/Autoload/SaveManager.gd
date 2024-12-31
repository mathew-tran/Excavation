extends Node

var Data = {}

signal SavingData
signal DataLoaded
signal DataSaved

var SaveFile = "user://excavation.save"


func SaveData(category, data):
	Data[category] = data
	
func HasData(category):
	return Data.has(category)
	
func GetData(category):
	if HasData(category):
		return Data[category]
	return null
	
func Save(bGetData = true):
	
	if bGetData:
		SavingData.emit()
	var saveFile = FileAccess.open(SaveFile, FileAccess.WRITE)
	if saveFile:
		saveFile.store_var(Data)
	saveFile.close()
	
	DataSaved.emit()
	# Save it to file.
	
func _input(event):
	if event.is_action_pressed("clear_data"):
		ClearData()
	
func Load():
	var saveFile = FileAccess.open(SaveFile, FileAccess.READ)
	if saveFile:
		Data = saveFile.get_var()
		saveFile.close()
	DataLoaded.emit()

func ClearData():
	Data = {}
	Save(false)
	get_tree().reload_current_scene()
