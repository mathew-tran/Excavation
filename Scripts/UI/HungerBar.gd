extends HBoxContainer


@onready var HungerIcon = preload("res://Prefabs/UI/HungerIcon.tscn")

func _ready() -> void:
	Finder.GetPlayer().GetHealthComponent().OnDeath.connect(OnDeath)
	Finder.GetPlayer().GetHungerComponent().OnHit.connect(OnHit)
	OnHit(Finder.GetPlayer().GetHungerComponent())
	visible = true
	
func OnHit(health : HealthComponent):
	for child in get_children():
		child.queue_free()
		
	var currentHealth = health.Health
	for amount in range(0, health.MaxHealth):
		var instance = HungerIcon.instantiate()
		add_child(instance)
		if amount >= currentHealth:
			instance.modulate = Color.BLACK
		
		var value = 0	
		if currentHealth - 1 > amount:
			value = 1
		else:
			var healthValue = currentHealth
			while healthValue >= 1:
				healthValue -= 1
			value = healthValue

		var progress = lerp(0, 100, value)
		instance.value = progress

func OnDeath(health: HealthComponent):
	visible = false
	
func Update():
	pass
	
