extends Node2D


onready var level_transition = $Camera2D/LevelTransition
var loading_world = bool(false)


# Func ready
func _ready():
	BattleManager.win_screen = self
	GlobalAudioManager.stop_track()


# Input
func _input(event):

	# Interacting
	if event.is_action_pressed("Interact") and loading_world == false:
		BattleTransitionManager.exit_battle()
		loading_world = true
