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
			"QuestProgression" : {},
			"Stats" : {}
		}
	
func OnSavingData():
	SaveManager.SaveData("Progression", Data)
	
func HasEntitlement(entitlementName):
	return Data["Entitlements"].has(entitlementName)
	
func SetEntitlement(entitlementName, value):
	Data["Entitlements"][entitlementName] = value
	
func IncrementStat(statType, amount):
	if Data["Stats"].has(statType):
		Data["Stats"][statType] += amount
	else:
		Data["Stats"][statType] = amount

func HasStat(statType):
	return Data["Stats"].has(statType)
	
func GetStatValue(statType):
	return Data["Stats"][statType]
