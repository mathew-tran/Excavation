extends AnimatedSprite2D

class_name GroundHealth

var AssociatedTile : Vector2i
var AssociatedTileType : TileData
var HealthLeft = 5
var StartingHealth = 5

func _ready() -> void:
	HealthLeft = StartingHealth
	SetFrame()
	var amount = randi_range(0, 3)
	rotation_degrees = amount * 90
	
func Heal():
	HealthLeft += .25
	$Timer.wait_time *= .50
	SetFrame()
	if HealthLeft >= StartingHealth:
		queue_free()
	
	
func Hit(amount):
	$Timer.wait_time = .75
	$Timer.start()
	HealthLeft -= amount
	SetFrame()
	if HealthLeft <= 0:
		# Destroy block
		Finder.GetMiningLayer().set_cell(AssociatedTile, -1)
		var item = AssociatedTileType.get_custom_data("Item")
		if item and item is ItemData:
			Helper.SpawnPickup(item, global_position)
		queue_free()

func GetHealthPercent():
	return float(HealthLeft) / float(StartingHealth)

func SetFrame():
	var healthRate = GetHealthPercent()
	var maxFrames = 4
	var newFrame = lerp(0, maxFrames, 1 - healthRate)
	
	frame = int(newFrame)


func _on_timer_timeout() -> void:
	Heal()
