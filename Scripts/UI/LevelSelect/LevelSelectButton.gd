extends Button

func _on_button_up():

	get_tree().change_scene_to_file("res://Scene/Main.tscn")
	#get_tree().change_scene_to_file(Level.resource_path)
