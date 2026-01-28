extends Area2D

@export var damage : int = 10
@export var animation_component : Node
@onready var attack_col: CollisionShape2D = $AttackCol

func _ready():
	animation_component.connect("facing_direction_changed", _on_enemy_facing_direction_changed)

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is Damageable:
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			
			if(direction_sign > 0):
				child.hit(damage, Vector2.RIGHT)
			elif(direction_sign < 0):
				child.hit(damage, Vector2.LEFT)
			else:
				child.hit(damage, Vector2.ZERO)
	pass # Replace with function body.

func _on_enemy_facing_direction_changed(facing_right : bool):
	if facing_right:
		attack_col.position.x = 16
	else:
		attack_col.position.x = -16
	
	
