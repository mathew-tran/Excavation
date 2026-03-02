extends HBoxContainer

@onready var HealthIcon = preload("res://Prefabs/UI/HealthIcon.tscn")
var HealthTexture

func _ready() -> void:
	Finder.GetPlayer().GetHealthComponent().OnDeath.connect(OnDeath)
	Finder.GetPlayer().GetHealthComponent().OnHit.connect(OnHit)
	OnHit(Finder.GetPlayer().GetHealthComponent())
	visible = true
	
func OnHit(health : HealthComponent):
	for child in get_children():
		child.queue_free()
		
	var currentHealth = health.Health
	for amount in range(0, health.MaxHealth):
		var instance = HealthIcon.instantiate()
		add_child(instance)
		if amount >= currentHealth:
			instance.modulate = Color.BLACK
	

func OnDeath(health: HealthComponent):
	visible = false
	
func Update():
	pass
	
