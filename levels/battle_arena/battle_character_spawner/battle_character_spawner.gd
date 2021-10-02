extends Node2D


func spawn_enemy(enemy_path):
	var loaded_enemy = load(enemy_path)
	var enemy_inst = loaded_enemy.instance()
	get_parent().add_child(enemy_inst)
	enemy_inst.position = position
	queue_free()
