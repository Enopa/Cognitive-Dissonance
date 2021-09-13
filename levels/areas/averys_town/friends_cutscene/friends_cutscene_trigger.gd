extends Node2D


var dialog_id = String("FriendsCutsceneDialog")
var player_cutscene_path = String("res://characters/overworld_characters/player/cutscene/averys_town/friends_cutscene/player_friends_cutscene.tscn")
var cutscene_id = String("FriendsCutscene")
var claire_name = String("Claire")


func _on_Area2D_body_entered(body):
	Global.player.enter_cutscene()
	var cutscene_instance = Global.player.enter_movement_cutscene(player_cutscene_path)
	cutscene_instance.connect("cutscene_finished", self, "on_cutscene_end")


func _ready():
	Global.connect("loaded_scene", self, "on_loaded")
	if CompletionManager.completed_cutscene_ids.find(cutscene_id) != -1:
		queue_free()


func on_loaded():
	if CompletionManager.completed_cutscene_ids.find(cutscene_id) != -1:
		queue_free()

func on_cutscene_end():
	var claire = get_tree().get_current_scene().get_node("YSort").get_node(claire_name)
	claire.follow_player()
	queue_free()
