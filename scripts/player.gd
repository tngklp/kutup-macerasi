extends CharacterBody2D

var moving = false
var facing = "down"
var speed = 100
@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var actionable_finder: Area2D = $ActionableFinder


func animate(sprite):
	if facing == "down":
		sprite.play("idle_down")
	elif facing == "up":
		sprite.play("idle_up")
	elif facing == "left":
		sprite.play("idle_left")
	elif facing == "right":
		sprite.play("idle_right")
	pass

func _ready():
	pass

func _physics_process(_delta):
	if global.can_move:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
		velocity = direction * speed
	
		if direction.x == 0 :
			if direction.y == 0:
				animate(player_sprite)
			elif direction.y == -1:
				facing = "up"
				player_sprite.play("walk_up")
			elif direction.y == 1:
				facing = "down"
				player_sprite.play("walk_down")
		elif direction.x == -1:
			facing = "left"
			player_sprite.play("walk_left")
		elif direction.x == 1:
			facing = "right"
			player_sprite.play("walk_right")

		move_and_slide()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			await get_tree().create_timer(2.0).timeout
			if actionables[0].dialogue_start != "quiz":
				actionables[0].dialogue_start = "searched"
			return
