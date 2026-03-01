extends Node2D

class_name Hand

func AttemptToUse():
	if $AnimationPlayer.is_playing() == false:
		$AnimationPlayer.play("swing")

func AttemptHit():
	Finder.GetCrosshair().AttemptToBreak()
