extends Node

class_name Damageable

signal on_hit(node: Node, damage_taken: int, knockback_direction: Vector2)
signal on_death(node: Node)

var isDying: bool = false

@export var max_health: float = 100
@onready var health: float = max_health

func hit(damage: int, knockback_direction: Vector2):
	if isDying: return
	health -= damage
	emit_signal("on_hit", get_parent(), damage, knockback_direction)
	if (health <= 0):
		isDying = true
		emit_signal("on_death", get_parent())
