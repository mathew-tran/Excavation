extends Area2D


func Start():
	$Timer.start()
	
func Stop():
	$Timer.stop()


func _on_timer_timeout():
	var collisions = get_overlapping_areas()
	for collision in collisions:
		var drop = collision.get_parent()
		drop.Magnetize()
		
