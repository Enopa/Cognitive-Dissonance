extends Node2D


var cutscene_id = String("FriendsCutscene")
var enemy = preload("res://characters/overworld_characters/enemies/brain_monster/brain_monster.tscn")


func _process(_delta):
	if CompletionManager.completed_cutscene_ids.find(cutscene_id) != -1:
		var enemy_instance = enemy.instance()
		enemy_instance.position = position
		get_parent().add_child(enemy_instance)
		queue_free()
