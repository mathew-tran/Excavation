extends Area2D


func _ready():
	if Progression.HasEntitlement("FIRST_TIME_GOLEM"):
		queue_free()
		return

func _on_area_entered(area):
	
	
	Finder.GetPlayer().DisablePlayerControls()
	var title = ""
	
	
	Finder.GetMessageBox().ShowMessage("This is a golem.", title)
	await Finder.GetMessageBox().MessageComplete
	
	Finder.GetMessageBox().ShowMessage("There are alot of golems that are found in mines.", title)
	await Finder.GetMessageBox().MessageComplete
	
	Finder.GetMessageBox().ShowMessage("Some golems are mean, some are nice.", title)
	await Finder.GetMessageBox().MessageComplete
	
	Finder.GetMessageBox().ShowMessage("Let's see what this one has to say.", title)
	await Finder.GetMessageBox().MessageComplete
	
	Progression.SetEntitlement("FIRST_TIME_GOLEM", 1)
	
	Finder.GetPlayer().EnablePlayerControls()
	SaveManager.Save()
	queue_free()
