extends Node2D


func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", global_position - Vector2(0,128), 1.2)
	await tween.finished
	queue_free()
	
func Setup(text):
	
	$Label.text = "Picked up " + text + "."
