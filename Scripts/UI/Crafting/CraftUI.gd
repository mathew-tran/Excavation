extends CanvasLayer

@onready var CraftContainer = $Panel/VBoxContainer/ScrollContainer/GridContainer
func _ready():
	
	await SaveManager.DataLoaded
	
	for child in CraftContainer.get_children():
		child.queue_free()
		
	var tracks = Helper.GetAllFilePaths("res://Data/Crafts/Tracks/")
	for track in tracks:
		var currentTrack = load(track) as CraftTrack
		var currentCraft = null
		if currentTrack.bUnlockedByDefault:
			currentCraft = currentTrack.GetNextCraft()
		if currentTrack.IsUnlocked():
			currentCraft = currentTrack.GetNextCraft()
		AttemptCreateNextCraft(currentCraft, currentTrack)
			
func AttemptCreateNextCraft(craft, track):
	if is_instance_valid(craft):
		var instance = load("res://Prefabs/UI/Crafting/CraftButton.tscn").instantiate() as CraftButton
		CraftContainer.add_child(instance)
		instance.CraftCompleted.connect(OnCraftCompleted)
		instance.Setup(craft, track)
			
func OnCraftCompleted(craftButton : CraftButton):
	craftButton.RelatedTrack.CraftCompleted(craftButton.CraftingResource)
	var nextCraft = craftButton.RelatedTrack.GetNextCraft()
	AttemptCreateNextCraft(nextCraft, craftButton.RelatedTrack)
		
	await get_tree().process_frame
	for child in $Panel/VBoxContainer/ScrollContainer/GridContainer.get_children():
		if child != craftButton:
			child.UpdateButton()
