extends Node2D


export var enemy_path = String("")
export var battle_id = String("")
export var battle_finish_dialog = String("")
var disabled = bool(false)


func _ready():
	BattleTransitionManager.connect("finished_battle", self, "on_battle_finished")
	Global.connect("loaded_scene", self, "on_loaded")

func _on_Area2D_body_entered(body):
	if disabled == false:
		BattleTransitionManager.enter_battle(enemy_path, battle_id)

func on_battle_finished():
	BattleCompletionManager.completed_battle_ids.append(battle_id)
	if BattleTransitionManager.current_battle_id == battle_id:
		disabled = true
		visible = false
		if battle_finish_dialog != "":
			var dialog = Dialogic.start(battle_finish_dialog)
			add_child(dialog)
			Global.player.talk()
			dialog.connect("timeline_end", self, "after_dialog")
		else:
			queue_free()

func on_loaded():
	if BattleCompletionManager.completed_battle_ids.find(battle_id) != -1:
		queue_free()

func after_dialog(timeline_name):
	yield(get_tree().create_timer(.1), "timeout")
	Global.player.stop_talking()
	queue_free()
