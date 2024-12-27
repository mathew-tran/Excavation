extends Node2D


func _ready():
	$AnimationPlayer.play("anim")
	
func Setup(text):	
	$Label.text = str(text).pad_decimals(2)


func _on_animation_player_animation_finished(anim_name):
	queue_free()
