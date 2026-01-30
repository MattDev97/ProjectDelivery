extends State

@onready var timer: Timer = $Timer

func on_enter():
	timer.start()

func _on_timer_timeout() -> void:
	Global.game_controller.change_gui_scene(
		"res://ui/player_ui/player_ui.tscn",
		true,
		false
	)
	
	Global.game_controller.change_2d_scene(
		"res://TestLevel.tscn",
		false,
		false
	)
