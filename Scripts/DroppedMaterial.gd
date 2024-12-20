extends Sprite2D

var MaterialDrop : MaterialResource

var bMoveTowardsPlayer = false
var Velocity = Vector2.ZERO
var StartPosition = Vector2.ZERO
var Progress = 0

func _ready():
	$Timer.wait_time = randf_range(.4, .9)
	$Timer.start()
	
func Setup(mat : MaterialResource):
	MaterialDrop = mat
	texture = MaterialDrop.MaterialImage
	var angle = randf() * 2 * PI
	Velocity = Vector2(cos(angle), sin(angle)).normalized()
	Velocity *= randf_range(80, 100)
	if randi_range(0, 10) >= 5:
		Velocity *= -1
	

func _process(delta):
	if bMoveTowardsPlayer == false:
		global_position += Velocity * delta
		StartPosition = global_position
	else:
		global_position = lerp(StartPosition, Finder.GetPlayer().global_position, Progress)
		Progress += delta * 10
		if global_position.distance_to(Finder.GetPlayer().global_position) < 10:
			queue_free()

func _on_timer_timeout():
	bMoveTowardsPlayer = true
