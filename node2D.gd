extends Node2D
func play_idle_animation():
	$AnimatedSprite2D.play("idle")
	
	
func play_run_animation():
		$AnimatedSprite2D.play("run")
		
func play_attacking_animation():
		$AnimatedSprite2D.play("attack")
		


func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.
