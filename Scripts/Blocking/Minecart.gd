extends Area2D


func _on_area_entered(_area):
	Finder.GetLevelSelect().Show()


func _on_area_exited(_area):
	Finder.GetLevelSelect().Hide()
