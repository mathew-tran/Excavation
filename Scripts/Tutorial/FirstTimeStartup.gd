extends Node


func _ready():
	await SaveManager.DataLoaded
	
	var title = "TUTORIAL"
	if Progression.HasEntitlement("FIRST_TIME_TUTORIAL"):
		queue_free()
		return
		
	Finder.GetPlayer().DisablePlayerControls()
	Finder.GetMessageBox().ShowMessage("Welcome Miner!", title)
	await Finder.GetMessageBox().MessageComplete
	
	Finder.GetMessageBox().ShowMessage("To your right is the minecart, you can use that to go to places to mine for materials", title)
	await Finder.GetMessageBox().MessageComplete
	
	Finder.GetMessageBox().ShowMessage("To your left is your crafting bench, will allow you to use those mined materials to create things.", title)
	await Finder.GetMessageBox().MessageComplete
	Finder.GetPlayer().EnablePlayerControls()
	
	Progression.SetEntitlement("FIRST_TIME_TUTORIAL", 1)
	SaveManager.Save()
