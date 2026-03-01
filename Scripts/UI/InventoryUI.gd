extends Panel
class_name InventoryUI

@onready var ItemUIClass = preload("res://Prefabs/UI/ItemUI.tscn")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Tab"):
		visible = !visible

func Populate():
	Clear()
	
	var data = Finder.GetPlayerInventory().Data
	for id in data.keys():
		var instance = ItemUIClass.instantiate() as ItemUI
		instance.ItemDataRef = Helper.GetItemFromID(id)
		instance.Amount = str(data[id])
		%ItemContainer.add_child(instance)
	
	
func Clear():
	for item in %ItemContainer.get_children():
		item.queue_free()
	
func _on_visibility_changed() -> void:
	if is_inside_tree() == false:
		return
		
	if visible:
		Populate()
		get_tree().paused = true
	else:
		Clear()
		get_tree().paused = false
