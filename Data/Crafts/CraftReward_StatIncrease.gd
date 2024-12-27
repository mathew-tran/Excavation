extends CraftReward

class_name CraftRewardStatIncrease

@export var Amount = 0.0
@export var StatRes : StatResource

func Give():
	Progression.IncrementStat(StatRes.StatName, Amount)
