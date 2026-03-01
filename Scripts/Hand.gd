extends Node2D

class_name Hand

func AttemptToUse():
	if $AnimationPlayer.is_playing() == false:
		$AnimationPlayer.play("swing")

func AttemptHit():
	var miningLayer = Finder.GetMiningLayer()
	var tile = miningLayer.local_to_map(miningLayer.to_local(get_global_mouse_position()))
	print(tile)
	var tileData = miningLayer.get_cell_tile_data(tile)
	print(tileData)
	if tileData:
		miningLayer.set_cell(tile, -1)
