extends AnimatedSprite2D

class_name GroundHealth

var AssociatedTile : Vector2i
var HealthLeft = 5
var StartingHealth = 5

func _ready() -> void:
	HealthLeft = StartingHealth
	SetFrame()
	
func Hit(amount):
	HealthLeft -= amount
	SetFrame()
	if HealthLeft <= 0:
		# Destroy block
		Finder.GetMiningLayer().set_cell(AssociatedTile, -1)
		queue_free()

func GetHealthPercent():
	return float(HealthLeft) / float(StartingHealth)

func SetFrame():
	var healthRate = GetHealthPercent()
	var maxFrames = 4
	var newFrame = lerp(0, maxFrames, 1 - healthRate)
	
	frame = int(newFrame)
