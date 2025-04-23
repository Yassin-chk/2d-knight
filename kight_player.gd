extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var health_bar = $HealthBar
@onready var damage_area = $PlayerDamageArea  # تأكد من الربط بالـ Area2D الخاص بالضرر

@export var health: float = 100
var speed = 600
var is_busy = false
var roll_speed = 800
var roll_direction = 1  # 1 for right, -1 for left
var is_monster_close = false
var can_attack = true
var damage = 15


func _physics_process(delta):
	if is_busy:
		if sprite.animation == "roll":
			velocity = Vector2(roll_direction * roll_speed, 0)
		move_and_slide()
		return
	var direction = Input.get_axis("left", "right")  # Returns -1, 0, or 1
	velocity = Vector2(direction * speed, 0)
	move_and_slide()
	if direction < 0:
		sprite.flip_h = true
		roll_direction = -1
	elif direction > 0:
		sprite.flip_h = false
		roll_direction = 1
	if direction != 0:
		sprite.play("run")
   
	if Input.is_action_just_pressed("roll"):
		sprite.play("roll")
		is_busy = true
	elif Input.is_action_just_pressed("attack"):
		is_busy = true
		velocity = Vector2.ZERO
		$PlayerDamageArea.monitoring = true  #  فعّل المنطقة
		$PlayerDamageArea/CollisionShape2D.disabled = false  # ← فعّل الشكل #Stop when attacking
		sprite.play("attack")
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")


func _on_animated_sprite_2d_animation_finished():
	# Once the current animation finishes, clear busy flag
	if sprite.animation in ["attack", "roll"]:
		is_busy = false
		$PlayerDamageArea.monitoring = false  #  عطل المنطقة
	$PlayerDamageArea/CollisionShape2D.disabled = true  #  عطل الشكل
# السيغنال ليتم تفعيله عندما يدخل جسم (مثل الوحش) داخل منطقة الهجوم
func _on_player_damage_area_body_entered(body: Node) -> void:
	if body.is_in_group("monsters"):  # الوحش في المجموعة
		if body.has_method("take_damage"):
			body.take_damage(damage)  # إعطاء الضرر للوحش
	print("hit")
