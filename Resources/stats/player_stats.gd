class_name PlayerStats
extends BaseStats

# --- OFFENSIVE ---
@export_group("Offensive Stats")
@export var critical_chance: float = 0.05 # 5% base crit
@export var critical_damage_multiplier: float = 1.5 # 150% damage on crit
@export var armor_penetration: float = 0.0

# --- MOBILITY ---
@export_group("Mobility")
@export var jump_force: float = 400.0
@export var max_jumps: int = 2 # Double jump standard
@export var dash_cooldown: float = 0.8
@export var dash_duration: float = 0.2
@export var dash_invincibility: bool = true

# --- PROGRESSION & ECONOMY ---
@export_group("Economy")
@export var gold: int = 0
@export var cells: int = 0 # Metagame currency
@export var experience: int = 0

# --- EQUIPMENT SLOTS ---
# In Godot, these can be other Resources (e.g., WeaponResource)
@export_group("Equipment")
@export var weapon_slot_1: Resource 
@export var weapon_slot_2: Resource 
@export var accessory_slot: Resource
@export var potion_slot: Resource

# --- STATUS EFFECTS ---
@export_group("Resistances")
@export var poison_resistance: float = 0.0
@export var stun_resistance: float = 0.0
@export var bleed_resistance: float = 0.0
