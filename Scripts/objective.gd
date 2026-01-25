extends Resource
class_name Objective

enum Type {
	Primary, Secondary
}

@export var objective_id = ""
@export var objective_text = ""
@export var type : Type = Type.Primary
@export var is_completed = false
@export var next_objective : Objective

func is_primary() -> bool:
	return type == Type.Primary
