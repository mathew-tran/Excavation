extends Node

func GetRocks():
	var result = get_tree().get_nodes_in_group("Rock")
	if result:
		return result
	return null
