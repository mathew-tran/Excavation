extends Area2D

@export var bGoHome = false

func _on_area_entered(_area):
	if bGoHome:
		Finder.GetGoHomePopup().Show()
	else:
		Finder.GetLevelSelect().Show()


func _on_area_exited(_area):
	if bGoHome:
		Finder.GetGoHomePopup().Hide()
	else:
		Finder.GetLevelSelect().Hide()	
