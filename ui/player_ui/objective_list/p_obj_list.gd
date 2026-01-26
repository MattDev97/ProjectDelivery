extends VBoxContainer

@export var listContainer : VBoxContainer

var objectives : Array[Objective] = [
	preload("res://resources/objectives/definitions/objective_get_order_for_andy.tres")
]

var objective_nodes : Array[Node] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for obj in objectives:
		add_new_objective(obj)
	Global.game_controller.connect("completed_objective", _on_completed_objective)

func _on_completed_objective(objective_id : String):
	for obj_node in objective_nodes:
		if objective_id == obj_node.obj_id && !obj_node.obj_completed:
			obj_node.complete_objective()
			if obj_node.next_objective != null:
				add_new_objective(obj_node.next_objective)

func add_new_objective(obj : Objective):
	print(obj)
	var newObjLabel = load("res://ui/player_ui/objective_list/primary_obj.tscn").instantiate()
	newObjLabel.obj_text = obj.objective_text
	newObjLabel.obj_id = obj.objective_id
	newObjLabel.next_objective = obj.next_objective
	listContainer.add_child(newObjLabel)
	objective_nodes.append(newObjLabel)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
