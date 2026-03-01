extends Label

var Progress = 1.0

func _process(delta: float) -> void:
	global_position.y -= delta * 50
	Progress -= delta
	if Progress <= 0:
		queue_free()
