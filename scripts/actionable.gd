extends Area2D

@export var dialogue_resource : DialogueResource
@export var dialogue_start : String

func action() -> void:
	global.can_move = false
	
	if dialogue_start == "quiz":
		if global.iron and global.silver and global.copper and not global.quiz:
			DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
			global.quiz = true
		else:
			global.can_move = true
	else:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
		if dialogue_start == "iron":
			global.iron = true
		elif dialogue_start == "silver":
			global.silver = true
		elif dialogue_start == "copper":
			global.copper = true
		
		await DialogueManager.dialogue_ended
		
		if global.iron and global.silver and global.copper:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/quiz.dialogue"), "start")
			await DialogueManager.dialogue_ended
		
		global.can_move = true
