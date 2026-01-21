# scenes/components/health_component.gd
class_name HealthComponent
extends Node

signal on_death
signal on_damage_taken(amount: int)

@export var max_health: float = 100.0
var current_health: float

func _ready():
	current_health = max_health

func take_damage(amount: float):
	current_health -= amount
	on_damage_taken.emit(amount)
	
	if current_health <= 0:
		on_death.emit()
