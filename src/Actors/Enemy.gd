extends "res://src/Actors/Actor.gd"

func _ready() -> void:
	# initially disable physics processing so enemy only starts moving
	# when the player sees it
	set_physics_process(false)
	# initially move left, towards the player
	_velocity.x = -speed.x
	
func _on_StompDetector_body_entered(body: Node) -> void:
	# if the player is below the detector, do nothing
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	
	# otherwise, make sure enemy can't be collided with and delete it
	get_node("CollisionShape2D").disabled = true
	queue_free()

func _physics_process(delta: float) -> void:
	# fall if not on ground
	_velocity.y += gravity * delta
	_velocity.y = min(_velocity.y, speed.y)
	
	# turn around when hit a wall
	if is_on_wall():
		_velocity.x *= -1.0
	
	_velocity.y = move_and_slide(_velocity, Vector2.UP).y
