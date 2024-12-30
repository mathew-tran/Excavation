extends VBoxContainer

var CraftReq

func _ready():
	Finder.GetInventory().AddItemAttempt.connect(OnInventoryUpdate)
	
func Setup(craftReq : CraftRequirement):
	$TextureRect.texture = craftReq.MaterialType.MaterialImage
	$Label.text = "X" + str(craftReq.MaterialAmount)
	CraftReq = craftReq	
	OnInventoryUpdate()

func OnInventoryUpdate():
	if  CraftReq.DoesMeetRequirement() == false:
		$NoMeetRequirement.text = "(" + str(Finder.GetInventory().GetItemAmount(CraftReq.MaterialType)) + ")"
		$NoMeetRequirement.visible = true
	else:
		$NoMeetRequirement.visible = false
		
func DoesMeetRequirement():
	return CraftReq.DoesMeetRequirement()
