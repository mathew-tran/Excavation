extends CraftReward

class_name CraftRewardUnlockTrack

@export var TrackToUnlock : CraftTrack

func Give():
	Progression.SetEntitlement(TrackToUnlock.TrackName, 1)
