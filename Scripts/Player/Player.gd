extends Sprite2D

class_name Player

signal ToolHasSwung

var CurrentTarget : Node2D
var Speed = 100

enum STATE {
	IDLE,
	LOOK_FOR_TASK,
	MOVE_TOWARDS_TARGET,
	MINE
}

var CurrentState = STATE.IDLE

func _ready():
	RunAI()
	
	
func _process(delta):
	if CurrentState == STATE.MOVE_TOWARDS_TARGET:
		MoveTowardsTarget(delta)


	
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
		CurrentState = STATE.MOVE_TOWARDS_TARGET
		return
	
	scale = Vector2(-1,1)
	$IdleTimer.start()
	await $IdleTimer.timeout	
	
	scale = Vector2(1,1)
	$IdleTimer.start()
	await $IdleTimer.timeout
	
	scale = Vector2(-1,1)
	$IdleTimer.start()
	await $IdleTimer.timeout
	
	CurrentState = STATE.IDLE
	RunAI()
	
func MoveTowardsTarget(delta):
	var direction = (CurrentTarget.global_position - global_position).normalized()
	var bIsAligned = false
	var bIsClose = false
	if global_position.x > CurrentTarget.global_position.x:
		scale = Vector2(-1,1)
	else:
		scale = Vector2(1,1)
	
	if global_position.distance_to(CurrentTarget.global_position) > 100:
		global_position += direction * Speed * delta
	else:
		bIsClose = true
	
	if bIsClose:
		if abs(global_position.y - CurrentTarget.global_position.y) > 5:
			if global_position.y < CurrentTarget.global_position.y:
				global_position.y += Speed * 2 * delta
			else:
				global_position.y -= Speed * 2 * delta
		else:
			bIsAligned = true
		
	if bIsAligned:
		if CurrentTarget is Rock:
			CurrentState = STATE.MINE
			StartSwingingTool()
	
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
	
func StartSwingingTool():
	$AnimationPlayer.play("SwingTool")

func StopSwingingTool():
	$AnimationPlayer.stop()
	CurrentState = STATE.IDLE
	RunAI()
