extends Control

onready var stats_label: Label = get_node("Label")

func _ready() -> void:
	stats_label.text = stats_label.text % [PlayerData.score, PlayerData.deaths]
