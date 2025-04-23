extends Node


func _ready() -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "start")
