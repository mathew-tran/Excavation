extends Node

func GetRocks():
	var result = get_tree().get_nodes_in_group("Rock")
	if result:
		return result
	return null

func GetPlayer() -> Player:
	var result = get_tree().get_nodes_in_group("Player")
	if result:
		return result[0]
	return null

func GetDropsGroup():
	var result = get_tree().get_nodes_in_group("Drops")
	if result:
		return result[0]
	return null

func GetInventory() -> Inventory:
	var result = get_tree().get_nodes_in_group("Inventory")
	if result:
		return result[0]
	return null
