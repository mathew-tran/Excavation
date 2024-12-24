extends Panel

@export var CraftingResource : CraftResource

@onready var ItemContainer = $VBoxContainer/GridContainer

signal CraftCompleted

func _ready():
	if Finder.GetInventory().bHasBeenLoaded == false:
		await Finder.GetInventory().InventoryLoaded
	$VBoxContainer/Title.text = CraftingResource.Title
	
	for item in ItemContainer.get_children():
		item.queue_free()
		
	var bIsPurchaseable = true
	for item in CraftingResource.Requirements:
		var instance = load("res://Prefabs/UI/Crafting/CraftRequirement.tscn").instantiate()
		instance.Setup(item)
		ItemContainer.add_child(instance)
		
	await get_tree().process_frame
	UpdateButton()
	
func UpdateButton():
	var bIsPurchaseable = true
	for item in ItemContainer.get_children():
		if item.DoesMeetRequirement() == false:
			bIsPurchaseable = false
		
	$VBoxContainer/Button.disabled = bIsPurchaseable == false
	
	
func _on_mouse_entered():
	Finder.GetInfoPopup().Show(CraftingResource.Description)


func _on_mouse_exited():
	Finder.GetInfoPopup().Hide()


func _on_button_button_up():
	# Assuming player has the right amount of materials.
	for item in ItemContainer.get_children():
		Finder.GetInventory().RemoveItem(item.CraftReq.MaterialType, item.CraftReq.MaterialAmount)
	CraftCompleted.emit()
	
	queue_free()
