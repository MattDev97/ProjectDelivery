# StatModifier.gd
class_name StatModifier extends RefCounted

enum Type {
	FLAT,           # Adds directly (e.g., +50 damage)
	PERCENT_ADD,    # Adds to a multiplier sum (e.g., +10% and +10% = +20%)
	PERCENT_MULT    # Multiplies the final result (e.g., x2 Damage)
}

var value: float
var type: Type
var source: Object # Optional: helps track "who" gave this buff (e.g., the Helmet)

func _init(_value: float, _type: Type, _source: Object = null):
	value = _value
	type = _type
	source = _source
