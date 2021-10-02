extends Node2D


var selected_move = int(0)
var active = bool(false)

onready var knife = $Knife
onready var magic = $Magic
onready var bag = $Bag
onready var selection_arrow = $SelectionArrow


# Func ready
func _ready():
	BattleManager.battle_ui = self


# Input
func _input(event):
	
	if BattleManager.battle_player != null:
		if BattleManager.battle_player.dead == false:

			# Cycling
			if event.is_action_pressed("CycleButtonRight"):
				if active == true:
					selected_move = clamp(selected_move + 1, 0, 2)
					reposition_arrow()
			if event.is_action_pressed("CycleButtonLeft"):
				if active == true:
					selected_move = clamp(selected_move - 1, 0, 2)
					reposition_arrow()

			if event.is_action_pressed("PressButton"):
				if active == true:
					if selected_move == 0: BattleManager.battle_player.attack_knife()
					elif selected_move == 1: BattleManager.battle_player.attack_magic()
					BattleManager.battle_camera.screenshake(1, .5, 0)


func reposition_arrow():
	if selected_move == 0:selection_arrow.position.x = knife.position.x - 24
	elif selected_move == 1: selection_arrow.position.x = magic.position.x - 24
	elif selected_move == 2: selection_arrow.position.x = bag.position.x - 24

func show_ui():
	visible = true
	active = true

func hide_ui():
	visible = false
	active = false
