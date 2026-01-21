# scenes/components/hurtbox_component.gd
class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent

func _ready():
	# Standard collision layer for "things that take damage"
	collision_layer = 0 
	collision_mask = 2 # Example: Detects Layer 2 (Hitboxes)

func receive_hit(damage: float):
	if health_component:
		health_component.take_damage(damage)
