extends Label

class_name Info

func Show(message):
	custom_minimum_size.y = 0
	custom_minimum_size.x = min(len(message) * 13, 280)
	size = custom_minimum_size
	text = message
	visible = true
	
	
	
func _process(_delta):
	if visible:
		global_position = get_global_mouse_position() + Vector2(0, 48)
	
func Hide():
	text = ""
	visible = false
