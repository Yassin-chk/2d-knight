extends CharacterBody2D

var health = 100
@export var speed = 15000
@onready var sprite = $AnimatedSprite2D
var damage = 50
var is_chasing_player: bool = false
@onready var target = get_node("/root/game/Player")
var can_attack = true
var player = null
var taking_damage = false

func _ready():
	# إضافة الوحش إلى المجموعة "monsters" ليتعرف عليه اللاعب
	add_to_group("monsters")

#func _physics_process(delta: float) -> void:
	#var direction = global_position.direction_to(target.global_position)
	#velocity = direction * speed * delta
	#velocity = Vector2.ZERO	
	#
	#move_and_slide()
func _physics_process(delta):
	if not player:
		return

	var distance = global_position.distance_to(player.global_position)
	var direction = (player.global_position - global_position).normalized()

	# إذا بعيد بتحرك
	if distance > 50:
		velocity = direction * speed
		move_and_slide()

		$AnimatedSprite2D.play("run")
	
		velocity = Vector2.ZERO
		move_and_slide()

		
		$AnimatedSprite2D.play("idle")

# الدالة تتعامل مع الضرر الذي يتلقاه الوحش
func take_damage(amount):
	health -= amount
	taking_damage = true 
	%AnimatedSprite2D.play("hurt")
	print(health)
	%HealthBar.value = health
	
	# إذا نفد الصحة، يموت الوحش
	if health <= 0:
		die()
# الدالة تتعامل مع موت الوحش	
func die():
	%AnimatedSprite2D.play("dead")
	await sprite.animation_finished
	queue_free()  # حذف الوحش من المشهد


	
	
	
	
	
	
	
