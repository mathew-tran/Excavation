extends Resource

class_name GolemDialogue

@export var Sentences : Array[String]

signal DialogueCompleted

func DoDialogue():
	Finder.GetPlayer().DisablePlayerControls()
	for sentence in Sentences:
		Finder.GetMessageBox().ShowMessage(sentence, "GOLEM")
		await Finder.GetMessageBox().MessageComplete
	
	DialogueCompleted.emit()
	Finder.GetPlayer().EnablePlayerControls()
