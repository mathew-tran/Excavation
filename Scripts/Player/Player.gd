extends RigidBody2D

class_name Player

signal ToolHasSwung

var CurrentTarget : Node2D
var Speed = 15000

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
var MoveObjectReference : MoveObject

var bCanAction = true

func DisablePlayerControls():
	bCanAction = false

func EnablePlayerControls():
	bCanAction = true
	
func _ready():
	lock_rotation = true
	MoveObjectReference = load("res://Prefabs/MoveObject.tscn").instantiate()
	get_parent().call_deferred("add_child", MoveObjectReference)
	await get_tree().process_frame
	SaveManager.Load()
	
	if Progression.HasEntitlement("MINING_SPEED_1"):
		IncreaseMiningSpeed(10.1)

func IncreaseMiningSpeed(amount):
	$Player/AnimationPlayer.speed_scale *= amount
	
func CanControlPlayer():
	return bCanAction
	
func _input(event):
	if CanControlPlayer() == false:
		return

	if event.is_action_pressed("right_click"):
		GoIdle()
		
func _process(_delta):
	if CanControlPlayer():
		if Input.is_action_pressed("click"):
			MoveToMouse()
	
func _physics_process(delta):
	if CurrentState == STATE.MOVE_TOWARDS_TARGET:
		MoveTowardsTarget(delta)
	else:
		linear_velocity = Vector2.ZERO
	
func RunAI():		
	if CurrentState == STATE.IDLE or CurrentState == STATE.SLEEP:
		LookForTask()	
	
func LookForTask():
	if $Player/SearchTimer.time_left != 0.0:
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
		$Player.scale = Vector2(-1,1)
	else:
		$Player.scale = Vector2(1,1)
	
	linear_velocity = direction * Speed * delta

	var bIsCloseToObject = false
	if global_position.distance_to(CurrentTarget.global_position) < 30:
		bIsCloseToObject = true		
		
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
	$Player/AnimationPlayer.play("SwingTool")

func StopSwingingTool():
	$Player/AnimationPlayer.stop()
	
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
