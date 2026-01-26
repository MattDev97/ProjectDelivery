extends State
@export var animated_sprite : AnimatedSprite2D

func on_enter():
	animated_sprite.play('walk')
