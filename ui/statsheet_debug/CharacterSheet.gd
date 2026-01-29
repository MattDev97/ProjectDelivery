# CharacterSheet.gd
extends Control

@onready var damage_row = $VBoxContainer/DamageRow
@onready var defense_row = $VBoxContainer/DefenseRow

# Call this when the menu opens, or when the player spawns
func setup_display(player: Player):
	# We hand the specific stat objects to the UI rows
	damage_row.initialize(player.damage_stat)
	defense_row.initialize(player.defense_stat)
