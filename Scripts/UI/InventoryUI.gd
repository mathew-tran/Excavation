extends Panel

signal CompleteInitialization

@onready var ContainerReference = $VBoxContainer/ScrollContainer/GridContainer
func _ready():
	ClearInventory()
	await get_tree().process_frame
	InitializeInventory()
	CompleteInitialization.emit()
	
func ClearInventory():
	for child in ContainerReference.get_children():
		child.queue_free()
		
func InitializeInventory():
	for invSlot in Finder.GetInventory().GetItems():
		var instance = load("res://Prefabs/UI/InventoryMaterial.tscn").instantiate()
		ContainerReference.add_child(instance)
		instance.Setup(invSlot)
	
func _on_mouse_entered():
	Finder.GetPlayer().DisablePlayerControls()


func _on_mouse_exited():
	Finder.GetPlayer().EnablePlayerControls()
