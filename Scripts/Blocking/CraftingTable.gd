extends StaticBody2D


func _on_area_2d_area_entered(area):
	$CanvasLayer.visible = true


func _on_area_2d_area_exited(area):
	$CanvasLayer.visible = false
