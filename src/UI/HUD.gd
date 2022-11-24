extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var score_label: Label = get_node("Label")

var is_paused: = false setget set_paused

func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	update_interface()

func _on_PlayerData_player_died() -> void:
	PlayerData.score = -20 * PlayerData.deaths
	scene_tree.reload_current_scene()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		# toggle is_paused through the setter
		self.is_paused = !is_paused
		# only this function will process the input event
		scene_tree.set_input_as_handled()

func update_interface() -> void:
	score_label.text = "Score: %s" % PlayerData.score

func set_paused(status: bool) -> void:
		is_paused = status
		scene_tree.paused = status
		
		pause_overlay.visible = status
