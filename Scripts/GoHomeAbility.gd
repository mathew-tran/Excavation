extends Panel

class_name GoHomeAbility

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("GoHome"):
		$Timer.start()
		visible = true
	if Input.is_action_just_released("GoHome"):
		$Timer.stop()
		visible = false
		
	if visible:
		$ProgressBar.value = 1 - ($Timer.time_left / $Timer.wait_time)
		


func _on_timer_timeout() -> void:
	Finder.GetPlayerInventory().ReduceInventoryByPercent(50.0)
	Finder.GetPlayerInventory().SaveInventory()
	get_tree().change_scene_to_file("res://Scenes/Hub.tscn")
	
