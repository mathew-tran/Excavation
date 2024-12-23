extends Sprite2D

class_name Player

signal ToolHasSwung

var CurrentTarget : Node2D
var Speed = 300

enum STATE {
	NULL,
	IDLE,
	LOOK_FOR_TASK,
	MOVE_TOWARDS_TARGET,
	SLEEP,
	MINE
}

var CurrentState = STATE.IDLE
var InjectedState = STATE.NULL
var CurrentPosition = Vector2.ZERO
var MoveObjectReference : MoveObject

var bCanAction = true

func DisablePlayerControls():
	bCanAction = false

func EnablePlayerControls():
	bCanAction = true
	
func _ready():
	MoveObjectReference = load("res://Prefabs/MoveObject.tscn").instantiate()
	get_parent().call_deferred("add_child", MoveObjectReference)
	await get_tree().process_frame
	SaveManager.Load()
	
func CanControlPlayer():
	return bCanAction
	
func _input(event):
	if CanControlPlayer() == false:
		return

	if event.is_action_pressed("right_click"):
		GoIdle()
		
func _process(delta):
	if CanControlPlayer():
		if Input.is_action_pressed("click"):
			MoveToMouse()
	$Label.text = STATE.keys()[CurrentState]
	if CurrentState == STATE.MOVE_TOWARDS_TARGET:
		MoveTowardsTarget(delta)
	
func RunAI():		
	if CurrentState == STATE.IDLE or CurrentState == STATE.SLEEP:
		LookForTask()	
	
func LookForTask():
	if $SearchTimer.time_left != 0.0:
		return
	
	if InjectedState != STATE.NULL:
		CurrentState = InjectedState
		InjectedState = STATE.NULL
		RunAI()		
		return
	
func SetTarget(object):
	if CurrentState == STATE.MINE:
		StopSwingingTool()
		
	InjectedState = STATE.MOVE_TOWARDS_TARGET
	CurrentPosition = global_position
	
	CurrentTarget = object
	RunAI()
	
func MoveToMouse():
	MoveObjectReference.global_position = get_global_mouse_position()	
	SetTarget(MoveObjectReference)
	MoveObjectReference.Show()
	
func MoveTowardsTarget(delta):
	if is_instance_valid(CurrentTarget) == false:
		GoIdle()
		return
		
	var direction = (CurrentTarget.global_position - global_position).normalized()
	if global_position.x > CurrentTarget.global_position.x:
		scale = Vector2(-1,1)
	else:
		scale = Vector2(1,1)
	
	var step = Speed * delta
	CurrentPosition = CurrentPosition.lerp(CurrentTarget.global_position, step/ CurrentPosition.distance_to(CurrentTarget.global_position))
	
	
	var bIsCloseToObject = false
	if CurrentPosition.distance_to(CurrentTarget.global_position) < 30:
		bIsCloseToObject = true		
	global_position = CurrentPosition
		
	if bIsCloseToObject:
		if CurrentTarget is Rock:
			CurrentState = STATE.MINE
			StartSwingingTool()
		if CurrentTarget is Bed:
			CurrentTarget.PlacePlayerInBed()
		if CurrentTarget is MoveObject:			
			CurrentState = STATE.IDLE
	
		MoveObjectReference.Hide()
	
func CompleteToolSwing():
	ToolHasSwung.emit()
	if is_instance_valid(CurrentTarget):
		if CurrentTarget is Rock:
			CurrentTarget.TakeDamage(2)
			
		await get_tree().create_timer(.1).timeout
		if is_instance_valid(CurrentTarget) == false:
			StopSwingingTool()
			
	else:
		StopSwingingTool()
	
func StartSwingingTool():
	$AnimationPlayer.play("SwingTool")

func StopSwingingTool():
	$AnimationPlayer.stop()
	
	if CurrentState != STATE.IDLE:
		GoIdle()

func GoIdle():
	CurrentState = STATE.IDLE
	RunAI()
	MoveObjectReference.Hide()
	StopSwingingTool()

func _on_area_2d_area_entered(area):
	if area is Door:
		area.Enter()
	pass # Replace with function body.
