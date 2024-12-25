extends Panel

class_name MessageBox

signal MessageComplete

var bIsInMessage = false

func ShowMessage(content, contentTitle = ""):
	visible = true
	bIsInMessage = true
	$VBoxContainer/Description.text = content
	$VBoxContainer/Title.text = contentTitle
	$VBoxContainer/Title.visible = len(contentTitle) != 0
	
func _input(event):
	if bIsInMessage == false:
		return
	if event.is_action_released("click"):		
		bIsInMessage = false
		visible = false
		await get_tree().create_timer(.1).timeout
		MessageComplete.emit()
