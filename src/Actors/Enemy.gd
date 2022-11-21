extends "res://src/Actors/Actor.gd"

func _ready() -> void:
	# initially move left, towards the player
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	# fall if not on ground
	_velocity.y += gravity * delta
	_velocity.y = min(_velocity.y, speed.y)
	
	# turn around when hit a wall
	if is_on_wall():
		_velocity.x *= -1.0
	
	_velocity.y = move_and_slide(_velocity, Vector2.UP).y
