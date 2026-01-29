# ItemData.gd
class_name ItemData extends Resource

@export var id: String = "item_id"
@export var display_name: String = "Item"
@export var icon: Texture2D
@export var is_stackable: bool = false
@export var max_stack: int = 99

@export var modifiers: Array[StatModifierData]
