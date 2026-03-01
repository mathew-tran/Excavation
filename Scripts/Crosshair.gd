extends Sprite2D

var PlayerRef : Player

func _ready() -> void:
	PlayerRef = Finder.GetPlayer()
	
func _process(delta: float) -> void:
	var newPosition = get_global_mouse_position() - Vector2(16,16)
	newPosition.x = snappedi(newPosition.x, 40)
	newPosition.y = snappedi(newPosition.y, 40)
	
	if newPosition.distance_to(PlayerRef.global_position) > PlayerRef.EffectivenessRange:
		modulate = Color.RED
	else:
		modulate = Color.WHITE
	global_position = newPosition
