extends Node

class_name Damageable

@export var animated_sprite_2d: AnimatedSprite2D
signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

var isDying : bool = false

@export var health : float = 50:
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

func hit(damage : int, knockback_direction : Vector2):
	print('got hit')
	if isDying: return
	health -= damage
	
	emit_signal("on_hit", get_parent(), damage, knockback_direction)
	if(health <= 0):
		#animated_sprite_2d.play("die")
		isDying = true
		

func _on_zombie_animation_finished() -> void:
	if animated_sprite_2d.animation == 'die':
		get_parent().queue_free()
