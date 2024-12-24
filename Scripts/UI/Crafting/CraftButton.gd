extends Panel


func _on_mouse_entered():
	Finder.GetInfoPopup().Show("This will increase your pick axe strength by 10%")


func _on_mouse_exited():
	Finder.GetInfoPopup().Hide()
