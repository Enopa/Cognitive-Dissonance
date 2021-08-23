extends Node2D


var opening_cutscene_id = String("GardenIntroCutscene")
var door_name = String("AverysStreetDoor")
var door_dialog_name = String("FrontDoorDialog")
var door
var door_dialog


func _ready():
	Global.connect("loaded_scene", self, "on_loaded")
	door = get_tree().get_current_scene().get_node(door_name)
	door_dialog = get_tree().get_current_scene().get_node(door_dialog_name)

func on_loaded():
	if CompletionManager.completed_cutscene_ids.find(opening_cutscene_id) != -1:
		door.locked = false
		door_dialog.enabled = false
		queue_free()
	else:
		door.locked = true
		door_dialog.enabled = true
