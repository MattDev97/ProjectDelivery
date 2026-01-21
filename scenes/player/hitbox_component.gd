# scenes/components/hitbox_component.gd
class_name HitboxComponent
extends Area2D

@export var damage_amount: float = 10.0

func _ready():
	collision_layer = 2 # Example: Is on Layer 2
	collision_mask = 0
	# Connect to Godot's built-in area_entered signal
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if area is HurtboxComponent:
		area.receive_hit(damage_amount)
