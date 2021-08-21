extends Camera2D


onready var screenshake = $Screenshake
onready var level_transition = $LevelTransition

# Func ready
func _ready():
	BattleManager.battle_camera = self

# Screenshake
func screenshake(strength, length, priority):
	screenshake.screen_shake(strength, length, priority)
