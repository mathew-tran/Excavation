extends RigidBody2D

class_name Pickup

var bIsMovingTowardsPlayer = false
@export var ItemType : ItemData

func _ready() -> void:
	if ItemType:
		$Sprite2D.texture = ItemType.ItemImage
		$AnimationPlayer.play("anim")
	
func MoveTowardsPlayer():
	if bIsMovingTowardsPlayer:
		return
	bIsMovingTowardsPlayer = true
	$AnimationPlayer.stop()
	$CollisionShape2D.queue_free()
	
func _process(delta: float) -> void:
	if bIsMovingTowardsPlayer:
		freeze = true
		
		global_position = global_position.move_toward(Finder.GetPlayer().global_position, delta * 500)
		if global_position.distance_to(Finder.GetPlayer().global_position) < 10:
			queue_free()
