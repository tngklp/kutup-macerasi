extends Node


func _ready() -> void:
	global.can_move = false
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "start")
	await DialogueManager.dialogue_ended
	global.can_move = true
