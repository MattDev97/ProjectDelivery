class_name BaseStats
extends Resource

@export_group("Vitality")
@export var max_health: float = 100.0
@export var defense: float = 0.0
@export var knockback_resistance: float = 0.0 # 0.0 to 1.0

@export_group("Combat")
@export var base_damage: float = 10.0
@export var attack_speed_modifier: float = 1.0 # Multiplier (e.g., 1.2 is +20%)

@export_group("Movement")
@export var move_speed: float = 200.0
