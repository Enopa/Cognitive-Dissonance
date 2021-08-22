extends Node2D


var opening_dialog_id = String("OpeningLevelDialog")
var first_level_path = String("res://levels/areas/averys_house/averys_room/averys_room.tscn")


func _ready():
	var dialog = Dialogic.start(opening_dialog_id)
	add_child(dialog)
	dialog.connect("timeline_end", self, "after_dialog")

func after_dialog(timeline_name):
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene(first_level_path)
	Global.load_data()
