extends CharacterBody2D

class_name Monster

@export var speed = 300
@onready var player = $"../Player"
@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	
	# Handle animations based on direction
	# var direction = global_position.direction_to(player.global_position)
	# velocity = direction * speed
	
	## Simple animation - just flip sprite based on x direction
	#if direction.x > 0:
		#sprite.flip_h = false  # Face right
	#elif direction.x < 0:
		#sprite.flip_h = true   # Face left
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		chase_player()

func chase_player() -> void:
	sprite.play("run")
	move_and_slide()
