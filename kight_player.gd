extends CharacterBody2D
var health = 100
var speed = 600	
@onready var sprite = $AnimatedSprite2D
var is_busy = false
var roll_speed = 800
var roll_direction = 1  # 1 for right, -1 for left

func _physics_process(delta):
	if is_busy:
		# Make the palyer move when rolling
		if sprite.animation == "roll":
			velocity = Vector2(roll_direction * roll_speed, 0)
		move_and_slide()
		return
	var direction = Input.get_axis("left", "right")  # Returns -1, 0, or 1
	velocity = Vector2(direction * speed, 0)
	# Normal movement
	move_and_slide()
	# Flip sprite when moving left
	if direction < 0:
		sprite.flip_h = true
		roll_direction = -1
	elif direction > 0:
		sprite.flip_h = false
		roll_direction = 1
	# Play run animation only while moving
	if direction != 0:
		sprite.play("run")

   
	if Input.is_action_just_pressed("roll"):
		sprite.play("roll")
		is_busy = true
	elif Input.is_action_just_pressed("attack"):
		is_busy = true
		velocity = Vector2.ZERO  #Stop when attacking
		sprite.play("attack")
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")
		
	

	


func _on_animated_sprite_2d_animation_finished():
	# Once the current animation finishes, clear busy flag
	if sprite.animation in ["attack", "roll"]:
		is_busy = false
		
		
		
		
		
		
		
func take_damage(amount):
	health -= amount
	sprite.play("dead")
	if health <= 0:
		die()
		
func die():
	# Handle player death
	get_tree().reload_current_scene()
