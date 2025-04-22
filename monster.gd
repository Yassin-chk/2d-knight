extends CharacterBody2D
@export var speed = 300
@onready var player = $"../Player"

func _physics_process(_delta):
	var sprite = $CollisionShape2D/AnimatedSprite2D
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
	
