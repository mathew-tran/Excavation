extends Panel

var InventorySlotReference : InventorySlot

func _ready():
	Hide()
	
func Setup(inventorySlot : InventorySlot):
	InventorySlotReference = inventorySlot
	
	$HBoxContainer.visible = true
	inventorySlot.Update.connect(OnUpdate)

	
	
func OnUpdate():
	$HBoxContainer/HBoxContainer/Amount.text = str(InventorySlotReference.Amount)
	$HBoxContainer/TextureRect.texture = InventorySlotReference.ItemType.MaterialImage
	$HBoxContainer/Info/Label.text = InventorySlotReference.ItemType.MaterialName
	Show()
	
func Show():
	$HBoxContainer/TextureRect.visible = true
	$HBoxContainer/HBoxContainer.visible = true
	
	
func Hide():
	$HBoxContainer/TextureRect.visible = false
	$HBoxContainer/HBoxContainer.visible = false
	
	

func _on_h_box_container_mouse_entered():
	$Panel.visible = true
	$HBoxContainer/Info.visible = true
	Finder.GetPlayer().DisablePlayerControls()

func _on_h_box_container_mouse_exited():
	$Panel.visible = false
	$HBoxContainer/Info.visible = false
