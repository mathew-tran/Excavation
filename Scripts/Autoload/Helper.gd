extends Node

var ItemResources : Array[MaterialResource]
func GetClosestRock(objectPosition):
	var rocks = Finder.GetRocks()
	if rocks == null:
		return null
	
	var closestRock = rocks[0]
	var distanceToClosestRock = rocks[0].global_position.distance_to(objectPosition)
	for rock in rocks:
		var distance = rock.global_position.distance_to(objectPosition)
		if is_instance_valid(closestRock) == false or distance < distanceToClosestRock:
			closestRock = rock
			distanceToClosestRock = distance
	
	if is_instance_valid(closestRock) == false:
		return null
	return closestRock

func GetMaterialFromID(idNumber) -> MaterialResource:
	GenerateItemResourcesIfNotLoaded()
	for resource in ItemResources:
		if resource.MaterialID == idNumber:
			return resource
	return null
	
func GenerateItemResourcesIfNotLoaded():
	if len(ItemResources) == 0:
		var files = Helper.GetAllFilePaths("res://Data/Materials/")
		for file in files:
			ItemResources.append(load(file))
			
	
func GetAllFilePaths(path: String) -> Array[String]:
	var file_paths: Array[String] = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		file_name = file_name.trim_suffix('.remap')
		var file_path = path + "/" + file_name
		if dir.current_is_dir():
			file_paths += GetAllFilePaths(file_path)
		else:
			file_paths.append(file_path)
		file_name = dir.get_next()
	return file_paths
