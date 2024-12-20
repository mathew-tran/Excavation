extends VBoxContainer

var MaterialType : MaterialResource

func Setup(mat : MaterialResource):
	MaterialType = mat
	$HBoxContainer/TextureRect.texture = MaterialType.MaterialImage
	UpdateUI()
	
func Update(materialID):
	if MaterialType.MaterialID == materialID:
		UpdateUI()
	
func UpdateUI():
	$HBoxContainer/Amount.text = 10
	
