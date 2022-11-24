extends Actor

export var stomp_impact: = 1000.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impact)

func _on_EnemyDetector_body_entered(body: Node) -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, get_direction(), speed, is_jump_interrupted)
	_velocity.y = move_and_slide(_velocity, Vector2.UP).y

func get_direction() -> Vector2:
	# moving to the right is 1.0, to the left is -1.0
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
		) -> Vector2:
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	
	# if was jumping but was interrupted
	if is_jump_interrupted:
		new_velocity.y = 0.0
	# if is jumping at the moment
	elif direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	else:
		new_velocity.y += gravity * get_physics_process_delta_time()
		new_velocity.y = min(new_velocity.y, speed.y)
	return new_velocity

func calculate_stomp_velocity(linear_velocity: Vector2, impact: float) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.y = -impact
	return new_velocity
