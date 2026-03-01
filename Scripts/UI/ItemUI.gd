extends Panel

class_name ItemUI

@export var ItemDataRef : ItemData
@export var Amount = 0

func _ready() -> void:
	if ItemDataRef:
		$Label.text = "x" + str(Amount)
		$TextureRect.texture = ItemDataRef.ItemImage


func _on_mouse_entered() -> void:
	Finder.GetInfoText().Show(ItemDataRef.ItemName)


func _on_mouse_exited() -> void:
	Finder.GetInfoText().Hide()
