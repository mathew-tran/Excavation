extends Node

class_name HealthComponent

var Health = 3
@export var MaxHealth = 3

signal OnDeath
signal OnHit

var bIsDead = false
@export var bCanDie = true

@export var bCanDelay = true
var bCanTakeDamage = true
var TimeBetweenDamage = .1
var DamageTakenTimer : Timer


func _ready() -> void:
	DamageTakenTimer = Timer.new()
	DamageTakenTimer.one_shot = true
	DamageTakenTimer.autostart = false
	DamageTakenTimer.wait_time = TimeBetweenDamage
	add_child(DamageTakenTimer)
	Setup()
	
func Setup():
	Health = MaxHealth
	
func CanTakeDamage():
	return DamageTakenTimer.time_left == 0.0
	
func CanHeal():
	return GetPercentage() < 90
	
func Heal(amount):
	Health += 1
	if Health >= MaxHealth:
		Health = MaxHealth
	OnHit.emit(self)
	
func GetPercentage():
	return float(Health) / float(MaxHealth) * 100
	
func TakeDamage(amount):
	if CanTakeDamage() == false:
		return
	if bIsDead:
		return
	
	if bCanDelay:
		DamageTakenTimer.start()
	Health -= amount
	OnHit.emit(self)
	if IsAlive() == false:
		if bCanDie:
			OnDeath.emit(self)
			bIsDead = true
		
func IsAlive():
	return Health > 0
