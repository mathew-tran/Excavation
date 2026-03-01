extends Node2D

class_name Hand

func AttemptToUse():
	if $AnimationPlayer.is_playing() == false:
		$AnimationPlayer.play("swing")

func AttemptHit():
	var hitPosition = get_global_mouse_position()
	if hitPosition.distance_to(Finder.GetPlayer().global_position) > Finder.GetPlayer().EffectivenessRange:
		return
	var miningLayer = Finder.GetMiningLayer()
	var tile = miningLayer.local_to_map(miningLayer.to_local(hitPosition))
	print(tile)
	var tileData = miningLayer.get_cell_tile_data(tile)
	print(tileData)
	if tileData:
		miningLayer.set_cell(tile, -1)
