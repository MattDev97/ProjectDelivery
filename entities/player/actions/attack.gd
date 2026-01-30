extends Area2D

@export var facing_shape: FacingCollisionShape2D
@export var attack_animation : Node2D

func _physics_process(_delta: float) -> void:
	var parent = get_parent()
	if parent is CharacterBody2D and parent.velocity.x != 0:
		_on_player_facing_direction_changed(parent.velocity.x > 0)

func _on_body_entered(body: Node2D) -> void:
	var damage = get_parent().stat_controller.get_value("damage")
	for child in body.get_children():
		if child is Damageable:
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			
			if (direction_sign > 0):
				child.hit(damage, Vector2.RIGHT)
			elif (direction_sign < 0):
				child.hit(damage, Vector2.LEFT)
			else:
				child.hit(damage, Vector2.ZERO)
	pass # Replace with function body.

func _on_player_facing_direction_changed(facing_right: bool):
	if facing_right:
		facing_shape.position = facing_shape.facing_right_position
		
		if attack_animation:
			attack_animation.position.x = -1 * attack_animation.position.x
	else:
		facing_shape.position = facing_shape.facing_left_position
		
		if attack_animation:
			attack_animation.position.x = -attack_animation.position.x
