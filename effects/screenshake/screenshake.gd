extends Node2D


var current_priority = 0


func move_camera(vector_range):
	get_parent().offset = Vector2(rand_range(-vector_range.x, vector_range.x), rand_range(-vector_range.y, vector_range.y))

func screen_shake(strength, length, priority):
	if priority >= current_priority:
		current_priority = priority
		$Tween.interpolate_method(self, "move_camera", Vector2(strength, strength), Vector2(0, 0), length, Tween.TRANS_SINE, Tween.EASE_OUT, 0)
		$Tween.start()

func _on_Tween_tween_completed(object, key):
	current_priority = 0
