extends Node2D

class_name Bed

func _on_button_button_up():
	Finder.GetPlayer().SetTarget(self)

func PlacePlayerInBed():
	Finder.GetPlayer().global_position = $PlacementPosition.global_position
	Finder.GetPlayer().CurrentState = Player.STATE.SLEEP
