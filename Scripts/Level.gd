extends Node2D

@export var LightColor : LightResource

func _ready():
	var colorMod = CanvasModulate.new()
	add_child(colorMod)
	colorMod.color = LightColor.LightColor
	
	await get_tree().create_timer(.2).timeout
	Transition.FadeOut()
