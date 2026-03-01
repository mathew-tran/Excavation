extends Node

func GetMiningLayer() -> TileMapLayer:
	return get_tree().get_nodes_in_group("MiningLayer")[0]

func GetPlayer() -> Player:
	return get_tree().get_nodes_in_group("Player")[0]
	
func GetCrosshair() -> CrossHair:
	return get_tree().get_nodes_in_group("Crosshair")[0]
	
func GetBlockHealthGroup() -> BlockHealthGroup:
	return get_tree().get_nodes_in_group("BlockHealthGroup")[0]
	
func GetFXGroup():
	return get_tree().get_nodes_in_group("FXGroup")[0]

func GetPlayerInventory() -> LocalInventory:
	return get_tree().get_nodes_in_group("LocalInventory")[0]
	
func GetInventoryUI() -> InventoryUI:
	return get_tree().get_nodes_in_group("InventoryUI")[0]
	
func GetInfoText() -> InfoText:
	return get_tree().get_nodes_in_group("InfoText")[0]
	
