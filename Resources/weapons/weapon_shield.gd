class_name ShieldWeaponResource
extends WeaponResource

@export_group("Defense Specs")
@export_range(0.0, 1.0) var damage_reduction: float = 0.75 # 75% block
@export var stamina_cost_per_block: float = 10.0

@export_group("Parry")
@export var can_parry: bool = true
@export var parry_window: float = 0.2 # The "perfect block" time window
# If you parry successfully, stun enemy for X seconds
@export var parry_stun_duration: float = 1.5
