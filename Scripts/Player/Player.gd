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

var PickDamage = 2


func DisablePlayerControls():
	bCanAction = false
	GoIdle()
	

func EnablePlayerControls():
	bCanAction = true
	
func _ready():
	lock_rotation = true
	MoveObjectReference = load("res://Prefabs/MoveObject.tscn").instantiate()
	get_parent().call_deferred("add_child", MoveObjectReference)
	await get_tree().process_frame
	SaveManager.Load()
	
	var damage = load("res://Data/Stats/STAT_AttackDamage.tres") as StatResource
	
	if Progression.HasStat(damage.StatName):
		PickDamage += Progression.GetStatValue(damage.StatName)
	
	var speed = load("res://Data/Stats/STAT_MoveSpeed.tres") as StatResource
	if Progression.HasStat(speed.StatName):
		Speed += Progression.GetStatValue(speed.StatName)
		
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
			CurrentTarget.TakeDamage(PickDamage + snappedf(randf_range(.1, .8), .01))
			$AudioStreamPlayer2D.pitch_scale = randf_range(.9,1.8)
			$AudioStreamPlayer2D.play()
			
		await get_tree().create_timer(.1).timeout
		if is_instance_valid(CurrentTarget) == false:
			StopSwingingTool()
			$RockBreak.pitch_scale = randf_range(.9, 1.2)
			$RockBreak.play()
			
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


func _on_voice_timer_timeout():
	var voices = ["res://Audio/Hum01.wav", "res://Audio/Hum02.wav", "res://Audio/Hum03.wav", "res://Audio/Hum04.wav", "res://Audio/Hum05.wav"]
	$Voice.stream = load(voices[randi() % len(voices)])
	$Voice.play()
	$VoiceTimer.stop()
	


func _on_voice_finished():
	$VoiceTimer.wait_time = randf_range(15, 30)
	$VoiceTimer.start()
