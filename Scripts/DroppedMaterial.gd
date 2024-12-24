extends Sprite2D

var MaterialDrop : MaterialResource

var bMoveTowardsPlayer = false
var bCanPickup = true
var Velocity = Vector2.ZERO
var StartPosition = Vector2.ZERO
var Progress = 0


func _ready():
	$Timer.wait_time = randf_range(.9, 1.2)
	$Timer.start()
	
func Setup(mat : MaterialResource):
	MaterialDrop = mat
	texture = MaterialDrop.MaterialImage
	var angle = randf() * 2 * PI
	Velocity = Vector2(cos(angle), sin(angle)).normalized()
	Velocity *= randf_range(100, 150)
	if randi_range(0, 10) >= 5:
		Velocity *= -1
	

func _process(delta):
	if bMoveTowardsPlayer == false:
		global_position += Velocity * delta
		StartPosition = global_position

func _on_timer_timeout():
	bMoveTowardsPlayer = true
	$Area2D.monitoring = true
	if len($Area2D.get_overlapping_areas()) > 0:
		PickupItem()

func PickupItem():
	if bCanPickup == false:
		return
	bCanPickup = false
	Finder.GetInventory().AddItem(MaterialDrop, 1)
	queue_free()

func _on_area_2d_area_entered(area):
	PickupItem()
