extends Node2D


var opening_dialog_id = String("GardenIntroDialog")
var opening_cutscene_id = String("GardenIntroCutscene")

var enemy_path = String("res://characters/battle_characters/enemies/battle_slime/battle_slime.tscn")
var battle_id = String("SlimeBattle")
var battle_finish_dialog = String("GardenMonsterSlainDialog")

onready var slime_garden_cutscene = $YSort/SlimeGardenCutscene

func _ready():
	BattleTransitionManager.connect("finished_battle", self, "on_battle_finished")

	if CompletionManager.completed_cutscene_ids.find(opening_cutscene_id) == -1:
		Global.player.enter_cutscene()
		yield(get_tree().create_timer(1), "timeout")
		var dialog = Dialogic.start(opening_dialog_id)
		add_child(dialog)
		Global.player.talk()
		dialog.connect("timeline_end", self, "after_dialog")
		dialog.connect("dialogic_signal", slime_garden_cutscene, "on_dialogic_signal")

func after_dialog(timeline_name):
	if CompletionManager.completed_cutscene_ids.find(opening_cutscene_id) == -1:
		yield(get_tree().create_timer(.1), "timeout")
		Global.player.stop_talking()
		Global.player.exit_cutscene()
		CompletionManager.completed_cutscene_ids.append(opening_cutscene_id)
		BattleTransitionManager.enter_battle(enemy_path, battle_id)
	else:
		yield(get_tree().create_timer(.1), "timeout")
		Global.player.stop_talking()
	
func on_battle_finished():
	CompletionManager.completed_battle_ids.append(battle_id)
	if BattleTransitionManager.current_battle_id == battle_id:
		if battle_finish_dialog != "":
			var dialog = Dialogic.start(battle_finish_dialog)
			add_child(dialog)
			Global.player.talk()
			dialog.connect("timeline_end", self, "after_dialog")
