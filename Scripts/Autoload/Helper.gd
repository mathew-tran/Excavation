extends Node

func GetClosestRock(objectPosition):
	var rocks = Finder.GetRocks()
	if rocks == null:
		return null
	
	var closestRock = rocks[0]
	var distanceToClosestRock = rocks[0].global_position.distance_to(objectPosition)
	for rock in rocks:
		var distance =  rock.global_position.distance_to(objectPosition)
		if distance < distanceToClosestRock:
			closestRock = rock
			distanceToClosestRock = distance
	
	return closestRock
