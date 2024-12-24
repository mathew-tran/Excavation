extends Node

var Data = {}

func _ready():
	SaveManager.SavingData.connect(OnSavingData)
	SaveManager.DataLoaded.connect(OnLoadedData)	
	
	
func OnLoadedData():
	Data = SaveManager.GetData("Progression")
	if Data == null:
		Data = {
			"Entitlements" : {},
			"QuestProgression" : {}
		}
	
func OnSavingData():
	SaveManager.SaveData("Progression", Data)
	
func HasEntitlement(entitlementName):
	return Data["Entitlements"].has(entitlementName)
	
func SetEntitlement(entitlementName, value):
	Data["Entitlements"][entitlementName] = value
	
