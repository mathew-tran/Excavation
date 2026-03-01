extends Node

func GetMiningLayer() -> TileMapLayer:
	return get_tree().get_nodes_in_group("MiningLayer")[0]

func GetPlayer() -> Player:
	return get_tree().get_nodes_in_group("Player")[0]
	
