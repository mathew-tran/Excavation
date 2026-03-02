extends Node

func GetMiningLayer() -> TileMapLayer:
	return get_tree().get_nodes_in_group("MiningLayer")[0]

func GetPlayer() -> Player:
	var result = get_tree().get_nodes_in_group("Player")
	if result:
		return result[0]
	return null
	
func GetCrosshair() -> CrossHair:
	return get_tree().get_nodes_in_group("Crosshair")[0]
	
func GetBlockHealthGroup() -> BlockHealthGroup:
	return get_tree().get_nodes_in_group("BlockHealthGroup")[0]
	
func GetFXGroup():
	return get_tree().get_nodes_in_group("FXGroup")[0]

func GetPlayerInventory() -> LocalInventory:
	return get_tree().get_nodes_in_group("LocalInventory")[0]
	
func GetGlobalInventory() -> LocalInventory:
	return get_tree().get_nodes_in_group("GlobalInventory")[0]
	
func GetInventoryUI() -> InventoryUI:
	return get_tree().get_nodes_in_group("InventoryUI")[0]
	
func GetGlobalChest():
	return get_tree().get_nodes_in_group("GlobalChest")[0]
	
func GetInfoText() -> InfoText:
	return get_tree().get_nodes_in_group("InfoText")[0]
	
