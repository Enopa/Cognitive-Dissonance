extends Node2D


var opening_cutscene_id = String("GardenIntroCutscene")

onready var animation_player = $AnimationPlayer


func _ready():
	if CompletionManager.completed_cutscene_ids.find(opening_cutscene_id) != -1:
		queue_free()

func on_dialogic_signal(param):
	if param == "MonsterMoveTowardPlayer":
		play_cutscene()

func play_cutscene():
	animation_player.play("SlimeGardenCutscene")
