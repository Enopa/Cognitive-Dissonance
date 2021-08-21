extends Node2D


export var dialog_id = ""


func _on_Area2D_body_entered(body):
	var dialog = Dialogic.start(dialog_id)
	add_child(dialog)
	Global.player.talk()
	dialog.connect("timeline_end", self, "after_dialog")

func after_dialog(timeline_name):
	yield(get_tree().create_timer(.1), "timeout")
	Global.player.stop_talking()
