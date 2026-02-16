extends Control

enum states { MAIN_MENU, CHAR_SELECT }

@onready var main_menu_container: VBoxContainer = $"Panel/MainMenu Container"
@onready var char_select: VBoxContainer = $Panel/CharSelect


var currentState = states.MAIN_MENU:
	get:
		return currentState 
	set(value):
		currentState = value
		
		match value:
			states.MAIN_MENU:
				main_menu_container.visible = true
				char_select.visible = false
			states.CHAR_SELECT:
				main_menu_container.visible = false
				char_select.visible = true

func _on_new_game_button_up() -> void:
	currentState = states.CHAR_SELECT

func _on_back_button_up() -> void:
	currentState = states.MAIN_MENU

func _on_char_select_button_up() -> void:
	Global.game_controller.change_gui_scene(
		"res://ui/player_ui/player_ui.tscn",
		true,
		false
	)
	
	Global.game_controller.change_2d_scene(
		"res://scenes/Parkour_level.tscn",
		false,
		false
	)
	
	Global.game_controller.background_manager.load_background("green_hill")


func _on_exit_button_up() -> void:
	get_tree().quit()
