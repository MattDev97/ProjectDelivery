extends State
@onready var timer: Timer = $Timer

func on_enter():
	animation_component.handle_travel_animation("die")
	character.velocity.x = 0
	timer.start()

func _on_timer_timeout() -> void:
	character.queue_free()
