extends HBoxContainer

# Get references to the nodes we need to modify
#@onready var bar_background: ColorRect = $BarBackground
#@onready var bar_fill: ColorRect = $BarBackground/BarFill

@onready var hp_background: ColorRect = $"HP Bar/HP Background"
@onready var bar_fill: ColorRect = $"HP Bar/HP Background/Bar Fill"

# Optional: Store the maximum width to avoid recalculating it if the UI is static
var max_width: float

func _ready() -> void:
	await get_tree().process_frame
	# 1. Capture the initial width of the background as our "100%"
	# Ensure the BarBackground has a Custom Minimum Size set in Inspector!
	max_width = hp_background.size.x
	
	# 2. Ensure the fill starts at 100% (matches background size)
	bar_fill.size = hp_background.size
	
	# 3. Set the color just to be safe (or set it in Inspector)
	bar_fill.color = Color.GREEN
	
func _process(delta) -> void:
	var player_health = Global.game_controller.player_health
	var max_player_health = Global.game_controller.max_player_health
	
	update_health(player_health, max_player_health)

# Call this function whenever the player takes damage or heals
# Example usage: update_health(75, 100)
func update_health(current_hp: float, max_hp: float) -> void:
	# Prevent division by zero crashes
	if max_hp <= 0:
		return
		
	# 1. Calculate the percentage (0.0 to 1.0)
	# We clamp it between 0 and 1 so the bar doesn't overfill or invert
	var percent: float = clampf(current_hp / max_hp, 0.0, 1.0)
	
	# 2. Calculate the new width in pixels
	var new_width: float = max_width * percent

	# 3. Apply the new width to the Green Bar
	bar_fill.size.x = new_width
	
	# Optional: Change color based on health low/high
	_update_color(percent)

# Helper to change color dynamically (Green -> Yellow -> Red)
func _update_color(percent: float) -> void:
	if percent > 0.6:
		bar_fill.color = Color.GREEN
	elif percent > 0.25:
		bar_fill.color = Color.YELLOW
	else:
		bar_fill.color = Color.RED
