extends Node2D

class_name Hand

func AttemptToUse():
	if $AnimationPlayer.is_playing() == false:
		$AnimationPlayer.play("swing")

func AttemptHit():
	if Finder.GetCrosshair():
		Finder.GetCrosshair().AttemptToBreak()




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "swing":
		$Timer.start()


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("RESET")
