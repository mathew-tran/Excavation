extends Node2D

class_name BlockHealthGroup
@onready var BlockHealthClass = preload("res://Prefabs/GroundHealth.tscn")

var MiningLayerRef
func _ready() -> void:
	MiningLayerRef = Finder.GetMiningLayer()
func GetTileCell(pos):
	
	var tile = GetTileCoords(pos)
	var tileData = MiningLayerRef.get_cell_tile_data(tile)
	if tileData:
		return tileData
	return null
	
func GetTileCoords(pos):
	var tile = MiningLayerRef.local_to_map(MiningLayerRef.to_local(pos))
	return tile
	
func AttemptToMinePosition(pos, damage):
	var tileHit = GetTileCell(pos)
	if tileHit == null:
		return
	var tileCoords = GetTileCoords(pos)
	for child in get_children():
		var instance = child as GroundHealth
		if instance.AssociatedTile == tileCoords:
			instance.Hit(damage)
			return
	var instance = BlockHealthClass.instantiate()
	instance.AssociatedTile = tileCoords
	instance.global_position = pos + Vector2(20,20)
	add_child(instance)
	instance.Hit(damage)
	
	
