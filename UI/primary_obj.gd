extends Label

@export var obj_id : String = ""
@export var obj_text : String = ""
@export var obj_completed : bool = false
@export var next_objective : Objective

func complete_objective() -> void:
	obj_completed = true
	
	set("theme_override_colors/font_color", Color(0.0, 0.627, 0.506, 0.039))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = obj_text
	pass
