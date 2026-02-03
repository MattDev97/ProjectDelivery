class_name ShakeableCamera extends Camera2D

var shaking := false
var remaining_time : float = 0
var elapsed_time : float = 0

var smoothness :float = 0.5 
var current_strength :float = 0

func rand_offset_from_strength() -> Vector2:
	var vec = Vector2()
	vec.x = randf_range(-current_strength, current_strength)
	vec.y = randf_range(-current_strength, current_strength)
	return vec

func shake(time: float, strength: float):
	remaining_time = time
	current_strength += strength 
	elapsed_time = 0.0
	
	# We interpret this vector as "how far we are from the center", 
	# so it should start at Zero.
	var shake_displacement := Vector2.ZERO 
	
	if not shaking:
		shaking = true
		
		# 1. Capture the original offset (e.g. your Y offset) 
		# before we start moving things around.
		var initial_offset = offset
		
		while elapsed_time < remaining_time:
			
			current_strength = lerpf(current_strength, 0, elapsed_time/remaining_time)
			
			# 2. Calculate the shake displacement separately from the actual offset
			shake_displacement = shake_displacement.lerp(rand_offset_from_strength(), 1-smoothness)
			shake_displacement = shake_displacement.lerp(Vector2.ZERO, elapsed_time/remaining_time)
			
			# 3. Apply the shake displacement ON TOP of the initial offset
			offset = initial_offset + shake_displacement
			
			elapsed_time += get_process_delta_time()
			await get_tree().process_frame
		
		# 4. When done, snap back to the exact initial offset
		offset = initial_offset
		shaking = false
