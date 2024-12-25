extends Node

func _ready():
	await SaveManager.DataLoaded
	
	var title = "TUTORIAL"
	if Progression.HasEntitlement("FIRST_TIME_MINING"):
		queue_free()
		return
		
	Finder.GetPlayer().DisablePlayerControls()
	Finder.GetMessageBox().ShowMessage("Take a crack at a few of those rocks!", title)
	await Finder.GetMessageBox().MessageComplete
	
	Finder.GetMessageBox().ShowMessage("When you are done here, use the mine cart to go back home!", title)
	await Finder.GetMessageBox().MessageComplete
	
	Finder.GetPlayer().EnablePlayerControls()
	
	Progression.SetEntitlement("FIRST_TIME_MINING", 1)
	SaveManager.Save()
