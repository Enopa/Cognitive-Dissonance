extends Node2D


onready var level_transition = $Camera2D/LevelTransition
var loading_new_battle = bool(false)


# Func ready
func _ready():
	BattleManager.death_screen = self
	GlobalAudioManager.stop_track()


# Input
func _input(event):

	# Interacting
	if event.is_action_pressed("Interact") and loading_new_battle == false:
		BattleTransitionManager.restart_battle()
		loading_new_battle = true
