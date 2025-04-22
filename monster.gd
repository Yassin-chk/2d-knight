extends CharacterBody2D

@export var speed = 15000
@onready var sprite = $AnimatedSprite2D

var is_chasing_player: bool = false
var target

func _physics_process(delta: float) -> void:
	
	# Handle animations based on direction
	#var direction = global_position.direction_to(player.global_position)
	#velocity = direction * speed
	
	## Simple animation - just flip sprite based on x direction
	#if direction.x > 0:
		#sprite.flip_h = false  # Face right
	#elif direction.x < 0:
		#sprite.flip_h = true   # Face left
	
	if is_chasing_player:
		sprite.play("run")
		move_and_slide()
		var direction = global_position.direction_to(target.global_position)
		velocity = direction * speed * delta
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Caught the player")
		is_chasing_player = true
		target = body
		
