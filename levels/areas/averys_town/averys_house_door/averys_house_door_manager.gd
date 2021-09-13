extends Node2D


var cutscene_id = String("FriendsCutscene")
var door_name = String("MainHallDoor")
var door_dialog_name = String("FriendsCutsceneAverysHouseDoorDialog")
var door
var door_dialog


func _ready():
	Global.connect("loaded_scene", self, "on_loaded")
	door = get_tree().get_current_scene().get_node(door_name)
	door_dialog = get_tree().get_current_scene().get_node("DialogTriggers").get_node(door_dialog_name)


func _process(_delta):
	if CompletionManager.completed_cutscene_ids.find(cutscene_id) == -1:
		door.locked = false
		door_dialog.enabled = false
	else:
		door.locked = true
		door_dialog.enabled = true
