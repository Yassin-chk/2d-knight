extends Node2D
func _on_RestartButton_pressed():
	get_tree().reload_current_scene()  # يعيد تحميل المشهد الحالي
	
	
func _on_player_health_depleted():
	%gameover.visible = true
	get_tree().paused = true
	
	
	
