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
		
	if Input.is_action_just_pressed("Debug_Death"):
		Finder.GetPlayer().GetHealthComponent().TakeDamage(1)
	if visible:
		$ProgressBar.value = 1 - ($Timer.time_left / $Timer.wait_time)
		


func _on_timer_timeout() -> void:
	Helper.MoveToHub(50.0)
	
