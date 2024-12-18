extends Sprite2D

class_name Player

signal ToolHasSwung

var CurrentTarget 

enum STATE {
	IDLE,
	LOOK_FOR_TASK,
	MINE
}

var CurrentState = STATE.IDLE

func _ready():
	RunAI()
	
	
func RunAI():
	if CurrentState == STATE.IDLE:
		LookForTask()	
	
func LookForTask():
	CurrentState = STATE.LOOK_FOR_TASK
	
	$SearchTimer.start()
	await $SearchTimer.timeout
	
	var closestRock = Helper.GetClosestRock(global_position)
	if closestRock:
		CurrentTarget = closestRock
		CurrentState = STATE.MINE
		SwingTool()
		return
	
	$SearchTimer.start()
	await $SearchTimer.timeout
	
	CurrentState = STATE.IDLE
	
func CompleteToolSwing():
	ToolHasSwung.emit()
	if is_instance_valid(CurrentTarget):
		if CurrentTarget is Rock:
			CurrentTarget.TakeDamage(2)
		
		await get_tree().create_timer(.01).timeout
		if is_instance_valid(CurrentTarget) == false:
			StopSwingingTool()
			
	else:
		StopSwingingTool()
	
func SwingTool():
	$AnimationPlayer.play("SwingTool")

func StopSwingingTool():
	$AnimationPlayer.stop()
