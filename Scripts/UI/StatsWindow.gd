extends Panel


func _ready():
	await SaveManager.DataLoaded
	Update()
	SaveManager.DataSaved.connect(Update)
	
func Update():
	await get_tree().create_timer(.1).timeout
	var damage = load("res://Data/Stats/STAT_AttackDamage.tres") as StatResource
	if Progression.HasStat(damage.StatName):
		$VBoxContainer/Strength.text = "Damage: " + str(Progression.GetStatValue(damage.StatName))
	else:
		$VBoxContainer/Strength.text = "Damage: "
		
	var speed = load("res://Data/Stats/STAT_MoveSpeed.tres") as StatResource
	if Progression.HasStat(speed.StatName):
		$VBoxContainer/MoveSpeed.text = "Speed: " + str(Progression.GetStatValue(speed.StatName))
	else:
		$VBoxContainer/MoveSpeed.text = "Speed: "
	
