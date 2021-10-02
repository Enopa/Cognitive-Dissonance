extends Node2D


var opening_cutscene_id = String("ExitHouseCutscene")
var dialog_id = String("ExitHouseDialog")


func _ready():
	Global.connect("loaded_scene", self, "on_loaded")


func on_loaded():
	if CompletionManager.completed_cutscene_ids.find(opening_cutscene_id) == -1:
		Global.player.enter_cutscene()
		yield(get_tree().create_timer(1), "timeout")
		var dialog = Dialogic.start(dialog_id)
		add_child(dialog)
		Global.player.talk()
		dialog.connect("timeline_end", self, "after_dialog")


func after_dialog(timeline_name):
	yield(get_tree().create_timer(.1), "timeout")
	Global.player.stop_talking()
	CompletionManager.completed_cutscene_ids.append(opening_cutscene_id)
	Global.player.exit_cutscene()
