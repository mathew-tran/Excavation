extends RigidBody2D

class_name Pickup

var bIsMovingTowardsTarget = false
@export var ItemType : ItemData
var Target : Node2D

var Speed = 500
func _ready() -> void:
	if ItemType:
		$Sprite2D.texture = ItemType.ItemImage
		$AnimationPlayer.play("anim")
	if Target == null:
		if Finder.GetPlayer():
			Target = Finder.GetPlayer()
	
func MoveTowardsTarget():
	if bIsMovingTowardsTarget:
		return
	bIsMovingTowardsTarget = true
	$AnimationPlayer.stop()
	$CollisionShape2D.queue_free()
	
func _process(delta: float) -> void:
	if bIsMovingTowardsTarget:
		freeze = true
		
		global_position = global_position.move_toward(Target.global_position, delta * Speed)
		if global_position.distance_to(Target.global_position) < 10:
			if Target is Player:
				Finder.GetPlayerInventory().AddItem(ItemType, 1, true)
			else:
				Finder.GetGlobalInventory().AddItem(ItemType, 1, true)
			queue_free()
	


func _on_timer_timeout() -> void:
	queue_free()


func _on_poll_timeout() -> void:
	modulate.a = ($Timer.time_left/$Timer.wait_time)
