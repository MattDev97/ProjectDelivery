# StatController.gd
class_name StatController extends Node

@export var starting_stats: StatSheet

# Lookup: String ID -> Stat Object
var _stats: Dictionary = {}

# Registry: Source Object -> Array of { "stat": Stat, "mod": StatModifier }
var _source_registry: Dictionary = {}

func _ready():
	if starting_stats:
		initialize_stats(starting_stats)

func initialize_stats(sheet: StatSheet):
	# Assuming StatSheet uses a Dictionary { StatDefinition : float_value }
	for def in sheet.base_stats.keys():
		var base_val = sheet.base_stats[def]
		
		# Create the Instance
		var new_stat = Stat.new(base_val)
		
		# KEY CHANGE: We map the string ID to the object
		# "strength" -> [Stat Object]
		if def.id != "":
			_stats[def.id] = new_stat
		else:
			push_warning("Stat Definition missing ID: " + def.resource_path)

# Now you access it purely via String
func get_stat(stat_id: String) -> Stat:
	if _stats.has(stat_id):
		return _stats[stat_id]
	
	push_error("Stat not found: " + stat_id)
	return null

func get_value(stat_id: String) -> float:
	var s = get_stat(stat_id)
	return s.get_value() if s else 0.0

# Call this when equipping an item
func add_modifiers_from_source(source: Object, data_list: Array[StatModifierData]):
	# 1. Prepare an array to track what we are about to add
	if not _source_registry.has(source):
		_source_registry[source] = []
	
	# 2. Loop through the item's data blueprints
	for data in data_list:
		var stat = get_stat(data.stat_id)
		
		if stat:
			# Create the runtime modifier
			var new_mod = StatModifier.new(data.value, data.type, source)
			
			# Apply it to the stat
			stat.add_modifier(new_mod)
			
			# RECORD IT: "This source added this modifier to this stat"
			var record = {
				"stat": stat,
				"modifier": new_mod
			}
			_source_registry[source].append(record)

# Call this when unequipping
func remove_modifiers_from_source(source: Object):
	if not _source_registry.has(source):
		return # This item wasn't contributing any stats
	
	# 1. Retrieve the list of modifiers this item created
	var records = _source_registry[source]
	
	# 2. Iterate and surgically remove them
	for record in records:
		var stat = record["stat"]
		var mod = record["modifier"]
		
		stat.remove_modifier(mod)
		
	# 3. Clear the registry entry
	_source_registry.erase(source)
