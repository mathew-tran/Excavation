extends Node

func GetMiningLayer() -> TileMapLayer:
	return get_tree().get_nodes_in_group("MiningLayer")[0]
	
