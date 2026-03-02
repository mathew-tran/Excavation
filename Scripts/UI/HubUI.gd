extends CanvasLayer

func _ready() -> void:
	visible = false
	Finder.GetPlayerSack().OnSackCompleted.connect(OnSackCompleted)

func OnSackCompleted():
	visible = true
