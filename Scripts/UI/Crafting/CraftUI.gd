extends CanvasLayer

func _ready():
	for child in $Panel/VBoxContainer/ScrollContainer/GridContainer.get_children():
		child.CraftCompleted.connect(OnCraftCompleted)
		
func OnCraftCompleted():
	for child in $Panel/VBoxContainer/ScrollContainer/GridContainer.get_children():
		child.UpdateButton()
