extends Sprite2D

func _ready() -> void:
	Finder.GetGlobalInventory().OnInventoryUpdate.connect(OnInventoryUpdate)
	
func OnInventoryUpdate():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("gainItem")
	
