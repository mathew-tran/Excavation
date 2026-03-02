extends CharacterBody2D

class_name Player

var Gravity = 30
var MinGravity = 9.8
var MoveSpeed = 8800
var JumpStrength = 500

var EffectivenessRange = 160

var bIsDead = false
var bStatic = false

var MinutesPerHungerPiece = 3

func GetHungerDecayRate(delta):
	var result = delta / (MinutesPerHungerPiece * 60)
	return result
	
func GetHealthComponent() -> HealthComponent:
	return $HealthComponent
	
func GetHungerComponent() -> HealthComponent:
	return $HungerComponent
	
func _ready() -> void:
	GetHealthComponent().OnDeath.connect(OnDeath)
	
func OnDeath(health : HealthComponent):
	KillPlayer()
	rotation_degrees = 90
	await Finder.GetPlayerInventory().ReduceInventoryByPercent(90)
	await get_tree().create_timer(1.5).timeout
	await get_tree().create_timer(2.5).timeout
	Helper.MoveToHub()
	
func MakeStatic():
	bStatic = true
	visible = false
	$CollisionShape2D.queue_free()
	
func KillPlayer():
	bIsDead = true
	
	$ItemPickupArea.queue_free()
	$Crosshair.queue_free()
	
func TakeDamage(dir, amount):
	if GetHealthComponent().CanTakeDamage():
		GetHealthComponent().TakeDamage(1)
		
		velocity = Vector2.ZERO
		velocity += dir * 500
		$AnimationPlayer.stop()
		$AnimationPlayer.play("hit")
		
func _process(delta: float) -> void:
	if bStatic:
		return
	if bIsDead:
		pass
	else:
		if GetHealthComponent().CanTakeDamage():
			for i in get_slide_collision_count():
				var collision = get_slide_collision(i)
				var tileData = Finder.GetBlockHealthGroup().GetTileCell(collision.get_position())
				if tileData:
					if tileData.get_custom_data("bHurt"):
							var direction = (global_position - collision.get_position()).normalized()
							TakeDamage(direction, 1)
							move_and_slide()
							return
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
		
	$HungerComponent.TakeDamage(GetHungerDecayRate(delta))
	move_and_slide()
	CheckHunger()
	
func CheckHunger():
	var hungerPercent = GetHungerComponent().GetPercentage()
	if hungerPercent > 70:
		StartTimer($SatedTimer)
		$HungerTimer.stop()
	elif hungerPercent <= 1:
		StartTimer($HungerTimer)
		$SatedTimer.stop()
	
func StartTimer(timer : Timer):
	if timer.time_left == 0.0:
		timer.start()
func IsGrounded():
	return is_on_floor()

func IsInAir():
	return is_on_floor() == false
	
func _physics_process(delta: float) -> void:
	
	if is_on_floor() == false:
		if Gravity <= 0:
			Gravity = MinGravity
		Gravity += delta * 2
		velocity.y += Gravity
	else:
		Gravity = 0
		velocity.y = 0
		$JumpTimer.stop()
		


func _on_sated_timer_timeout() -> void:
	GetHealthComponent().Heal(1)


func _on_hunger_timer_timeout() -> void:
	TakeDamage(Vector2(.2, 0), 1)
