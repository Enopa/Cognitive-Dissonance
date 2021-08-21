extends Node2D


onready var spawn_location = $SpawnLocation


func spawn_enemy(enemy_path):
	var loaded_enemy = load(enemy_path)
	var enemy_inst = loaded_enemy.instance()
	get_parent().add_child(enemy_inst)
	enemy_inst.position = spawn_location.position
	queue_free()
