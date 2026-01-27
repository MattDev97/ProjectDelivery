class_name BackgroundManager
extends Node2D 

# Cache your resources (Same as before)
const BACKGROUNDS = {
	"green_hill": preload("res://resources/backgrounds/definitions/bg_green_hill.tres")
}

func load_background(bg_id: String):
	if not BACKGROUNDS.has(bg_id):
		push_error("Background ID not found: " + bg_id)
		return
	
	_build_parallax(BACKGROUNDS[bg_id])

func _build_parallax(def: BackgroundDef):
	# 1. Clear existing layers
	for child in get_children():
		child.queue_free()
	
	# Get the viewport height to calculate scaling
	var viewport_height = get_viewport().get_visible_rect().size.y
	
	# 2. Build new Parallax2D nodes
	for layer_data in def.layers:
		var tex: Texture2D = layer_data.texture
		# Default values if resource is missing data
		var speed_x: float = 1-layer_data.speed_x if layer_data.speed_x else 1.0
		var offset_y: float = layer_data.offset_y if layer_data.offset_y else 0.0
		
		if tex == null: continue
		
		var p_node = Parallax2D.new()
		
		# --- SCALING LOGIC START ---
		var scale_factor = 1.0
		var tex_height = tex.get_height()
		
		# Check if texture is shorter than screen
		if tex_height < viewport_height:
			# Calculate how much we need to grow to fit the height
			scale_factor = viewport_height / float(tex_height)
		
		# Apply scroll speed
		p_node.scroll_scale = Vector2(speed_x, 1.0)
		
		# IMPORTANT: We must scale the repeat_size too!
		# If the image is 2x bigger, the loop point must be 2x further away.
		var mirror_x = def.default_mirroring_x
		if mirror_x == 0:
			mirror_x = tex.get_width()
			
		# Apply the scale to the repeat behavior
		p_node.repeat_size = Vector2(mirror_x * scale_factor, 0)
		p_node.repeat_times = 3
		# ---------------------------

		# Create the Sprite
		var sprite = Sprite2D.new()
		sprite.texture = tex
		sprite.centered = false
		sprite.position.y = offset_y
		
		# Apply the scale to the visual sprite
		# Usage: Vector2(scale_factor, scale_factor) keeps aspect ratio (Recommended)
		# Usage: Vector2(1.0, scale_factor) stretches ONLY height (Distorts image)
		sprite.scale = Vector2(scale_factor, scale_factor)
		# Inside _build_parallax, before adding child:
		p_node.z_index = -100 + (speed_x * -10) # Puts slower (farther) layers further back
		p_node.ignore_camera_scroll = false
		
		p_node.add_child(sprite)
		add_child(p_node)
	# 1. Clear existing layers (children)
	for child in get_children():
		child.queue_free()
	
	# 2. Build new Parallax2D nodes
	for layer_data in def.layers:
		var tex: Texture2D = layer_data.get("texture")
		var speed_x: float = layer_data.get("speed_x", 1.0) # 0.0 = Far, 1.0 = Close
		var offset_y: float = layer_data.get("offset_y", 0.0)
		
		if tex == null: continue
		
		# --- NEW PARALLAX2D SETUP ---
		var p_node = Parallax2D.new()
		
		# A. Scroll Scale (formerly Motion Scale)
		# This determines how fast it moves relative to the camera
		p_node.scroll_scale = Vector2(speed_x, 1.0)
		
		# B. Repeat Size (formerly Motion Mirroring)
		# How big is the image before it needs to loop?
		var mirror_x = def.default_mirroring_x
		if mirror_x == 0:
			mirror_x = tex.get_width()
		
		p_node.repeat_size = Vector2(mirror_x, 0)
		
		# C. Infinite Repeat
		# Parallax2D can auto-repeat texture to fill screen
		p_node.repeat_times = 3 # Draw it 3 times horizontally to ensure coverage
		
		# D. The Visuals
		var sprite = Sprite2D.new()
		sprite.texture = tex
		sprite.centered = false
		sprite.position.y = offset_y
		
		# Add sprite to the Parallax2D node
		p_node.z_index = -100 + (speed_x * 10)
		p_node.add_child(sprite)
		
		# Add Parallax2D to our container
		add_child(p_node)
