class_name GameController extends Node

@export var world_2d : Node2D
@export var gui : CanvasLayer

var current_2d_scene
var current_gui_scene

var character = 'Bob'

var player_health = 100

signal completed_objective(objective_name)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.game_controller = self
	Global.game_controller.change_gui_scene(
		"res://UI/main_menu.tscn",
		true,
		false
	)
	
func complete_objective(objective_id: String):
	emit_signal("completed_objective", objective_id)

func select_character(char_name: String):
	character = char_name
	
func player_health_update(hp):
	if hp != player_health:
		player_health = hp

func change_gui_scene(new_scene: String, delete: bool = true, keep_running: bool = false):
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free()
		elif keep_running:
			current_gui_scene.visible = false
		else:
			gui.remove_child(current_gui_scene)
	var new = load(new_scene).instantiate()
	gui.add_child(new)
	new.set_anchors_preset(Control.PRESET_FULL_RECT, true)
	current_gui_scene = new

func change_2d_scene(new_scene: String, delete: bool = true, keep_running: bool = false):
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free()
		elif keep_running:
			current_2d_scene.visible = false
		else:
			world_2d.remove_child(current_2d_scene)
	var new = load(new_scene).instantiate()
	world_2d.add_child(new)
	current_2d_scene = new
