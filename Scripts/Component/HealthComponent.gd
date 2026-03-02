extends Node

class_name HealthComponent

var Health = 3
@export var MaxHealth = 3

signal OnDeath
signal OnHit

var bIsDead = false

func _ready() -> void:
	Setup()
	
func Setup():
	Health = MaxHealth
	
func TakeDamage(amount):
	if bIsDead:
		return
		
	Health -= amount
	OnHit.emit(self)
	if IsAlive() == false:
		OnDeath.emit(self)
		bIsDead = true
		
func IsAlive():
	return Health > 0
