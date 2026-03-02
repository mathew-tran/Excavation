extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Finder.GetPlayerInventory().SaveInventory()
		get_tree().change_scene_to_file("res://Scenes/Hub.tscn")
		queue_free()
