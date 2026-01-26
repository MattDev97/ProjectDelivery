class_name RangedWeaponResource
extends WeaponResource

@export_group("Ranged Specs")
# Drag your PackedScene of the projectile (arrow, fireball) here
@export var projectile_scene: PackedScene 

@export var projectile_speed: float = 600.0
@export var projectile_count: int = 1 # Shotgun spread support
@export var spread_angle: float = 0.0 # Spread in degrees

@export_group("Cost")
@export var ammo_per_shot: int = 1
@export var ammo_type: String = "arrow" # or "mana"
