extends "res://characters/overworld_characters/enemy_base/enemy_base.gd"


var dialog_id = String("BrainMonsterEndBattleFriendsDialog")
var cutscene_id = String("BrainMonsterEndBattleFriendsCutscene")


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("loaded_scene", self, "on_loaded")
	if CompletionManager.completed_battle_ids.find(battle_id) != -1 and CompletionManager.completed_cutscene_ids.find(cutscene_id) == -1:
		end_battle_cutscene()


func on_loaded():
	if CompletionManager.completed_battle_ids.find(battle_id) != -1 and CompletionManager.completed_cutscene_ids.find(cutscene_id) == -1:
		end_battle_cutscene()

func end_battle_cutscene():
	get_tree().change_scene("res://levels/demo_end/demo_end.tscn")
