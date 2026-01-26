class_name MeleeWeaponResource
extends WeaponResource

@export_group("Melee Specs")
# If true, attacking again within a window triggers the next animation in the chain
@export var is_combo_weapon: bool = true 
@export var combo_window: float = 0.8 

# Hitbox size for the area2D detector
@export var hitbox_extents: Vector2 = Vector2(30, 50) 
@export var knockback_force: float = 300.0

# Optional: Special movement (e.g., slight lunge forward on swing)
@export var lunge_speed: float = 100.0
