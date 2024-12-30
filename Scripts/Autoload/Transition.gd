extends CanvasLayer

class_name TransitionScene

func FadeIn():
	var tween = get_tree().create_tween().tween_property($Transition, "modulate", Color(0,0,0,1), .50)
	await tween.finished
	print("Faded in")
	
func FadeOut():
	var tween = get_tree().create_tween().tween_property($Transition, "modulate", Color(0,0,0,0), .50)
	await tween.finished
	print("Faded out")

func Teleport(newScene):
	if Finder.GetPlayer():
		Finder.GetPlayer().DisablePlayerControls()
	await FadeIn()
	get_tree().change_scene_to_file(newScene)
	
