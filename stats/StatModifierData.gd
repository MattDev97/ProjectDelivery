# StatModifierData.gd
class_name StatModifierData extends Resource

# Which stat does this affect? (Matches the ID in your Controller)
@export var stat_id: String = "" 
@export var value: float = 0.0
@export var type: StatModifier.Type = StatModifier.Type.FLAT
