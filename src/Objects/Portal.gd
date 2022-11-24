tool
extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
onready var scene_tree: = get_tree()
export var next_scene: PackedScene

func _on_body_entered(_body: Node) -> void:
	teleport()
	
func _get_configuration_warning() -> String:
	if not next_scene:
		return "'Next Scene' can't be empty."
	else:
		return ""

func teleport() -> void:
	anim_player.play("fade_in")
	# wait for animation to finish before switching scenes
	yield(anim_player, "animation_finished")
	scene_tree.change_scene_to(next_scene)
