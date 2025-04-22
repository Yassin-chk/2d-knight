extends CharacterBody2D

@export var speed = 300
@onready var player = $"../Player"
@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	
	# Handle animations based on direction
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	
	## Simple animation - just flip sprite based on x direction
	#if direction.x > 0:
		#sprite.flip_h = false  # Face right
	#elif direction.x < 0:
		#sprite.flip_h = true   # Face left
	
	# Play run animation (you need a "run" animation in your AnimatedSprite2D)
	sprite.play("run")
	
	# Smooth movement
	move_and_slide()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Caught the player")
