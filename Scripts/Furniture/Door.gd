extends Node2D

class_name Door

@export var SceneRef : PackedScene

func Enter():
	get_tree().change_scene_to_packed(SceneRef)
