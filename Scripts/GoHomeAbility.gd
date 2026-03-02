extends Panel

class_name GoHomeAbility
var bComplete = false

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if bComplete:
		return
	if Input.is_action_just_pressed("GoHome"):
		$Timer.start()
		visible = true
	if Input.is_action_just_released("GoHome") or Finder.GetPlayer().IsInAir():
		$Timer.stop()
		visible = false
		
	if Input.is_action_just_pressed("Debug_Death"):
		Finder.GetPlayer().GetHealthComponent().TakeDamage(1)
	if visible:
		$ProgressBar.value = 1 - ($Timer.time_left / $Timer.wait_time)
		


func _on_timer_timeout() -> void:
	bComplete = true
	visible = false
	Finder.GetPlayer().KillPlayer()
	Finder.GetPlayer().MakeStatic()
	await Finder.GetPlayerInventory().ReduceInventoryByPercent(50)
	await get_tree().create_timer(1.5).timeout
	Helper.MoveToHub()
	
