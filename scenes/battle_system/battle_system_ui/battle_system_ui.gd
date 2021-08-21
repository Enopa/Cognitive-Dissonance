extends Node2D


var selected_move = int(0)
var active = bool(false)

onready var knife = $Knife
onready var magic = $Magic
onready var punch = $Punch
onready var flee = $Flee
onready var selection_arrow = $SelectionArrow


# Func ready
func _ready():
	BattleManager.battle_ui = self


# Input
func _input(event):
	
	if BattleManager.battle_player != null:
		if BattleManager.battle_player.dead == false:

			# Cycling
			if event.is_action_pressed("CycleButtonDown"):
				if active == true:
					selected_move = clamp(selected_move + 1, 0, 2)
					reposition_arrow()
			if event.is_action_pressed("CycleButtonUp"):
				if active == true:
					selected_move = clamp(selected_move - 1, 0, 2)
					reposition_arrow()

			if event.is_action_pressed("PressButton"):
				if active == true:
					if selected_move == 0: BattleManager.battle_player.attack_knife()
					elif selected_move == 1: BattleManager.battle_player.attack_magic()
					elif selected_move == 2: BattleManager.battle_player.attack_punch()


func reposition_arrow():
	if selected_move == 0: selection_arrow.position.y = knife.position.y
	elif selected_move == 1: selection_arrow.position.y = magic.position.y
	elif selected_move == 2: selection_arrow.position.y = punch.position.y

func show_ui():
	visible = true
	active = true

func hide_ui():
	visible = false
	active = false
