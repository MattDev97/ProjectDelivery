extends State
class_name AttackState

@export var return_state : State
@export var attack_col : CollisionShape2D
@export var attack_damage : float = 10.0

# Timer for "combo" windows (optional, but good for polish)
var is_attacking : bool = false

func on_enter():
	is_attacking = true
	
	# 1. Stop Movement (Optional: allow small slide if you want)
	character.velocity.x = 0
	
	# 2. Play Animation
	# Assuming your AnimationComponent handles this, or direct call:
	character.animated_sprite_2d.play("attack")
	
	# 3. Enable Hitbox (Deferred is safer for physics)
	if attack_col:
		attack_col.set_deferred("disabled", false)
	
	# 4. Listen for animation finish to exit state
	if not character.animated_sprite_2d.animation_finished.is_connected(_on_animation_finished):
		character.animated_sprite_2d.animation_finished.connect(_on_animation_finished)

func on_exit():
	is_attacking = false
	
	# Disable Hitbox immediately
	if attack_col:
		attack_col.set_deferred("disabled", true)
	
	# Clean up signal
	if character.animated_sprite_2d.animation_finished.is_connected(_on_animation_finished):
		character.animated_sprite_2d.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished():
	# Automatically go back to Ground (which will switch to Idle or Run)
	if is_attacking:
		character.set_next_state('Idle')
