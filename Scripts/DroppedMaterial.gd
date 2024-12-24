extends Sprite2D

var MaterialDrop : MaterialResource

var bMoveTowardsPlayer = false
var bCanPickup = true
var Velocity = Vector2.ZERO
var Progress = 0

var bMagnetized = false

func _ready():
	$Timer.wait_time = randf_range(.3, .6)
	$Timer.start()
	
func Setup(mat : MaterialResource):
	MaterialDrop = mat
	texture = MaterialDrop.MaterialImage
	var angle = randf() * 2 * PI
	Velocity = Vector2(cos(angle), sin(angle)).normalized()
	Velocity *= randf_range(150, 210) * 1.2
	if randi_range(0, 10) >= 5:
		Velocity *= -1
	
func Magnetize():
	if bMagnetized == false:
		$MagnetizedTimer.start()
		bMagnetized = true
	
func _process(delta):
	if bMoveTowardsPlayer == false:
		global_position += Velocity * delta
	elif bMagnetized:
		global_position = global_position.move_toward(Finder.GetPlayer().global_position, delta * 180)
		
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


func _on_magnetized_timer_timeout():
	bMagnetized = false
	
