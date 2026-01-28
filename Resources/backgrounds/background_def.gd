class_name BackgroundDef
extends Resource

@export_group("Settings")
# Defines the texture, speed, and standard mirroring for each layer
# We use an Array of Dictionaries because creating a separate Resource for every single layer is overkill.
# Format: { "texture": Texture2D, "speed_x": 0.5, "offset_y": 0.0 }
@export var layers: Array[Dictionary] = [
	{
		"texture" : null,
		"speed_x" : null,
		"offset_y" : null
	},
	{
		"texture" : null,
		"speed_x" : null,
		"offset_y" : null
	},
	{
		"texture" : null,
		"speed_x" : null,
		"offset_y" : null
	},
	{
		"texture" : null,
		"speed_x" : null,
		"offset_y" : null
	},
	{
		"texture" : null,
		"speed_x" : null,
		"offset_y" : null
	}
]

@export var background_bg : CompressedTexture2D = null
@export var default_mirroring_x: float = 0.0 # 0 = Auto-detect based on texture width
