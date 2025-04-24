extends CharacterBody2D


@export var speed = 500
@onready var sprite = $AnimatedSprite2D
@onready var target = get_node("/root/game/Player")
@onready var attack_area = $Area2D
var can_attack = true
var is_alive = true
var taking_damage = false
var damage = 10
var health = 150

enum State {IDLE, RUN, HURT, DEAD, ATTACK} # متغيرات جديدة للتحكم بالحالة
var current_state = State.IDLE


#func _physics_process(delta: float) -> void:
	#var direction = global_position.direction_to(target.global_position)
	#velocity = direction * speed * delta
	#velocity = Vector2.ZERO	
	#
	#move_and_slide()
	
func _ready():
	add_to_group("monsters")
	# البحث عن اللاعب عند بدء التشغيل
	target = get_tree().get_first_node_in_group("player")  # طريقة أكثر أمانًا
	if not target:
		print("تحذير: لم يتم العثور على اللاعب")

func _physics_process(delta):
	if !is_alive:
		return
	
	# إعادة تعيين السرعة أولاً
	velocity = Vector2.ZERO
	
	if target and not taking_damage:
		var direction = global_position.direction_to(target.global_position)
		
		# التحكم في الحركة
		if direction.length() > 0.3:
			change_state(State.RUN)
			velocity = direction * speed
			# قلب الصورة حسب الاتجاه
			sprite.flip_h = direction.x < 0
	elif can_attack:
		change_state(State.ATTACK)
		can_attack = false
		await get_tree().create_timer(0.4).timeout  # انتظر ثانية قبل السماح بالهجوم مرة تانية
		can_attack = true
	
	move_and_slide()

# دالة لتغيير الحالة وتشغيل الرسوم المتحركة المناسبة
func change_state(new_state):
	if current_state == new_state:
		return
	
	current_state = new_state
	
	match current_state:
		State.IDLE:
			sprite.play("idle")
		State.RUN:
			sprite.play("run")
		State.HURT:
			sprite.play("hurt")
		State.DEAD:
			sprite.play("dead")
		State.ATTACK:
			sprite.play("attacking")
			if attack_area.get_overlapping_bodies():
				for body in attack_area.get_overlapping_bodies():
					if body.is_in_group("player"):
						body.take_damage(damage)  # يضرب اللاعب
			
func take_damage(amount):
	if !is_alive:
		return
	
	health -= amount
	taking_damage = true
	change_state(State.HURT)
	print(health)
	%HealthBar.value = health
	%HealthBar.max_value = 100.0
	
	if health <= 0:
		die()
	else:
		# إعادة تعيين حالة الضرر بعد فترة
		await get_tree().create_timer(1.5).timeout
		taking_damage = false

func die():
	is_alive = false
	change_state(State.DEAD)
	await sprite.animation_finished
	queue_free()

	
	
	
	
	
	
	
