extends State

@export var animated_sprite_2d: AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func on_enter():
	animated_sprite_2d.play('idle')
