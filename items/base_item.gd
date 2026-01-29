extends Area2D

@export var item_data : ItemData
@export var iconSprite : Sprite2D

func _ready() -> void:
	iconSprite.texture = item_data.icon

func _on_body_entered(body: Node2D) -> void:
	if body is Player && item_data:
		body.equip_item(item_data)
		queue_free()
	pass # Replace with function body.
