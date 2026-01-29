# Stat.gd
class_name Stat extends RefCounted

signal value_changed(new_value)

var _base_value: float
var _modifiers: Array[StatModifier] = []
var _cached_value: float = 0.0
var _is_dirty: bool = true # Forces calculation on first run

func _init(base: float = 0.0):
	_base_value = base

# --- Core Functions ---

func get_value() -> float:
	if _is_dirty:
		_cached_value = _calculate_value()
		_is_dirty = false
	return _cached_value

func set_base_value(value: float):
	_base_value = value
	_is_dirty = true
	value_changed.emit(get_value())

func add_modifier(mod: StatModifier):
	_modifiers.append(mod)
	_is_dirty = true
	value_changed.emit(get_value())

func remove_modifier(mod: StatModifier):
	_modifiers.erase(mod)
	_is_dirty = true
	value_changed.emit(get_value())

# Remove all modifiers from a specific source (e.g., unequip a sword)
func remove_modifiers_from_source(source: Object):
	# Iterate backward when removing items from an array
	for i in range(_modifiers.size() - 1, -1, -1):
		if _modifiers[i].source == source:
			_modifiers.remove_at(i)
	_is_dirty = true
	value_changed.emit(get_value())

# --- The Math ---
# Order of Operations: (Base + Flat) * (1 + Sum of %Add) * (Product of %Mult)
func _calculate_value() -> float:
	var final_value = _base_value
	var sum_percent_add = 0.0
	
	# 1. Apply Flat Modifiers
	for mod in _modifiers:
		if mod.type == StatModifier.Type.FLAT:
			final_value += mod.value
	
	# 2. Sum up Percent Additive Modifiers
	for mod in _modifiers:
		if mod.type == StatModifier.Type.PERCENT_ADD:
			sum_percent_add += mod.value
	
	# Apply the additive percentage (e.g., 50 * (1 + 0.30))
	final_value *= (1.0 + sum_percent_add)
	
	# 3. Apply Percent Multiplicative (rare, powerful buffs)
	for mod in _modifiers:
		if mod.type == StatModifier.Type.PERCENT_MULT:
			final_value *= mod.value
			
	return final_value
