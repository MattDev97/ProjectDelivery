extends State
@onready var timer: Timer = $Timer

func on_enter():
	character.velocity.x = 0
	timer.start()

func _on_timer_timeout() -> void:
	character.queue_free()
