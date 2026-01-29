# StatSheet.gd
class_name StatSheet extends Resource

# We use a dictionary to map StatDefinition -> float (Base Value)
# Exporting dictionaries can be tricky in Godot 4, so we often use an array of a custom helper class or just a raw dictionary if simple.
@export var base_stats: Dictionary = {} 
# Note: In Inspector, you drag the StatDefinition resource as the Key, and type the number as Value.

func get_base_value(stat_def: StatDefinition) -> float:
	if base_stats.has(stat_def):
		return base_stats[stat_def]
	return 0.0
