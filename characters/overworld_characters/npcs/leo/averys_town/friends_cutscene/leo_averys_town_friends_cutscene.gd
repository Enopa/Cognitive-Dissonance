extends KinematicBody2D


var follower_path = String("res://characters/overworld_characters/npcs/leo/averys_town/follower/leo_averys_town_follower.tscn")
var cutscene_id = String("FriendsCutscene")


func follow_player():
	Global.player.follow_player(follower_path, position)
	queue_free()


func _ready():
	Global.connect("loaded_scene", self, "on_loaded")
	if CompletionManager.completed_cutscene_ids.find(cutscene_id) != -1:
		queue_free()


func on_loaded():
	if CompletionManager.completed_cutscene_ids.find(cutscene_id) != -1:
		queue_free()
