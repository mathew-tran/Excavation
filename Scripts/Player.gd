extends CharacterBody2D

class_name Player

var Gravity = 30
var MinGravity = 9.8
var MoveSpeed = 8800
var JumpStrength = 500

var EffectivenessRange = 160

var bIsDead = false

func GetHealthComponent() -> HealthComponent:
	return $HealthComponent
	
func _ready() -> void:
	GetHealthComponent().OnDeath.connect(OnDeath)
	
func OnDeath(health : HealthComponent):
	bIsDead = true
	rotation_degrees = 90
	$ItemPickupArea.queue_free()
	$Crosshair.queue_free()
	
	
func _process(delta: float) -> void:
	if bIsDead:
		pass
	else:
		if get_global_mouse_position().x <= global_position.x:
			$Sprite.scale = Vector2(-1,1)
		else:
			$Sprite.scale = Vector2(1,1)

		if Input.is_action_pressed("Swing"):
			$Sprite/Hand.AttemptToUse()
		var inputVelocity = Vector2.ZERO
		if Input.is_action_pressed("Left"):
			inputVelocity.x = -1
		if Input.is_action_pressed("Right"):
			inputVelocity.x = 1
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			if $JumpTimer.time_left == 0.0:
				velocity.y -= JumpStrength
				$JumpTimer.start()
		if inputVelocity != Vector2.ZERO:
			velocity.x = inputVelocity.x * MoveSpeed * delta
		else:
			velocity.x = 0
		
	move_and_slide()
	
func _physics_process(delta: float) -> void:
	
	if is_on_floor() == false:
		if Gravity <= 0:
			Gravity = MinGravity
		Gravity += delta * 2
		velocity.y += Gravity
	else:
		Gravity = 0
		velocity.y = 0
		
