extends Sprite2D

class_name Rock

var Health = 10
@export var MaxHealth = 10

@export var DropChances : RockDropChance

func _ready():
	flip_h = randi_range(0, 1)
	flip_v = randi_range(0, 1)
	Health = MaxHealth
	
func TakeDamage(amount):
	var instance = load("res://Prefabs/UI/DamageText.tscn").instantiate()
	
	instance.Setup(amount)
	Finder.GetDropsGroup().add_child(instance)
	instance.global_position = global_position
	Health -= amount
	
	if Health <= 0:
		for drop in DropChances.MaterialsToDrop:
			drop.Open(global_position)
		queue_free()
		return
	else:
		var result = randi_range(0, 1)
		if result == 0:
			$AnimationPlayer.play("hit")
		else:
			$AnimationPlayer.play("hit2")
	
	material = load("res://Materials/RockHit.tres")
	$HitTimer.start()

func _on_button_button_up():
	Finder.GetPlayer().SetTarget(self)


func _on_hit_timer_timeout():
	material = null
