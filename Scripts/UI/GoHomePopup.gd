extends Panel

class_name GoHomePopup

func Show():
	visible = true
	
func Hide():
	visible = false
	


func _on_no_button_button_up():
	Hide()

func _on_yes_button_button_up():
	get_tree().change_scene_to_file("res://Scene/Hub.tscn")
