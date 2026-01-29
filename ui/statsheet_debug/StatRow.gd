# StatRow.gd
extends HBoxContainer

@export var stat_name: String = "Stat"
@onready var name_label = $NameLabel
@onready var value_label = $ValueLabel

var _linked_stat: Stat

func _ready():
	name_label.text = stat_name

# This is the key: We "Inject" the stat object here
func initialize(stat_to_watch: Stat):
	_linked_stat = stat_to_watch
	
	# 1. Update the UI immediately with the current value
	_update_label(_linked_stat.get_value())
	
	# 2. Listen for future changes automatically
	# Disconnect first to avoid double-connections if re-initialized
	if _linked_stat.value_changed.is_connected(_update_label):
		_linked_stat.value_changed.disconnect(_update_label)
		
	_linked_stat.value_changed.connect(_update_label)

func _update_label(new_value):
	# You can format this (e.g., round to int)
	value_label.text = str(round(new_value))
