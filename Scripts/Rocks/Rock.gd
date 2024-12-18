extends Sprite2D

class_name Rock

var Health = 10
var MaxHealth = 10

var SpriteDir = "res://Art/Rocks/Rock1/Rock"


func TakeDamage(amount):
	Health -= amount
	
	if Health <= 0:
		queue_free()
	else:
		texture = load(GetHealthStage())
		$AnimationPlayer.play("hit")
	
func GetHealthStage():
	var percent = float(float(Health) / float(MaxHealth))
	print(percent)
	if percent > .8:
		return SpriteDir + "0.png"
	elif percent > .4:
		return SpriteDir + "1.png"
	else:
		return SpriteDir + "2.png"
