class_name WeaponResource
extends Resource

@export_group("Visuals")
@export var item_name: String = "Weapon Name"
@export var texture: Texture2D
@export_multiline var description: String

@export_group("General Combat")
@export var damage: float = 10.0
@export var cooldown: float = 0.5 # Time between uses
@export var animation_name: String = "attack_1"
