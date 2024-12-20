extends Sprite2D

class_name Rock

var Health = 10
var MaxHealth = 10

var SpriteDir = "res://Art/Rocks/Rock1/Rock"
@export var DropChances : Array[MaterialDropChance]

func _ready():
	flip_h = randi_range(0, 1)
	flip_v = randi_range(0, 1)
	
func TakeDamage(amount):
	Health -= amount
	
	if Health <= 0:
		for drop in DropChances:
			drop.Open(global_position)
		queue_free()
	else:
		texture = load(GetHealthStage())
		var result = randi_range(0, 1)
		if result == 0:
			$AnimationPlayer.play("hit")
		else:
			$AnimationPlayer.play("hit2")
	
func GetHealthStage():
	var percent = float(float(Health) / float(MaxHealth))
	print(percent)
	if percent > .8:
		return SpriteDir + "0.png"
	elif percent > .4:
		return SpriteDir + "1.png"
	else:
		return SpriteDir + "2.png"


func _on_button_button_up():
	Finder.GetPlayer().SetTarget(self)
