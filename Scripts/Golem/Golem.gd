extends StaticBody2D

@export var InitialSentence : GolemDialogue
@export var PassSentence : GolemDialogue
@export var FailSentence : GolemDialogue

@export var Requirement : CraftRequirement

var bHasDoneInitialSentence = false

@export var Entitlement : EntitlementResource

func _ready():
	if Progression.HasEntitlement(Entitlement.EntitlementID):
		queue_free()
		
func _on_area_2d_area_entered(area):
	Finder.GetPlayer().DisablePlayerControls()
	if bHasDoneInitialSentence == false:
		await InitialSentence.DoDialogue()
		bHasDoneInitialSentence = true
	if Requirement.DoesMeetRequirement():
		Finder.GetInventory().RemoveItem(Requirement.MaterialType, Requirement.MaterialAmount)
		await PassSentence.DoDialogue()
		await Transition.FadeIn()
		Entitlement.Give()
		SaveManager.Save()
		Transition.FadeOut()
		Finder.GetPlayer().EnablePlayerControls()
		queue_free()
	else:
		await FailSentence.DoDialogue()
