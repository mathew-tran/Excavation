extends Label

class_name InfoText

func _ready() -> void:
	visible = false
	
	
func _process(delta: float) -> void:
	if visible:
		global_position = get_global_mouse_position() + Vector2(0,32)
	
func Show(newText):
	text = newText	
	size = Vector2.ZERO
	visible = true

func Hide():
	visible = false
	
