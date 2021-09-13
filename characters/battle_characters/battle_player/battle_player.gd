extends "res://characters/battle_characters/battle_character_base.gd"


var is_players_turn = bool(false)
var damage_to_apply = int(0)
var spam_prevention_damage = int(1)
var found_bullet_up = bool(false)
var found_bullet_down = bool(false)
var found_bullet_left = bool(false)
var found_bullet_right = bool(false)

onready var attack_audio_player = $AttackAudioPlayer
onready var damage_audio_player = $DamageAudioPlayer
onready var hurtbox_area = $HurtboxArea
onready var hit_note_player = $HitNotePlayer
onready var heal_audio_player = $HealAudioPlayer
onready var arrow_area_up = $ArrowAreaUp
onready var arrow_area_down = $ArrowAreaDown
onready var arrow_area_left = $ArrowAreaLeft
onready var arrow_area_right = $ArrowAreaRight
onready var arrow_sprite_up = $ArrowAreaUp/Sprite
onready var arrow_sprite_down = $ArrowAreaDown/Sprite
onready var arrow_sprite_left = $ArrowAreaLeft/Sprite
onready var arrow_sprite_right = $ArrowAreaRight/Sprite


# Func ready
func _ready():
	BattleManager.battle_player = self


# Input
func _input(event):

	if dead == false and BattleManager.battle_enemy != null:

		# Arrows
		if event.is_action_pressed("UpArrow"):
			if is_players_turn == false:
				arrow_sprite_up.frame = 1
				found_bullet_up = false
				for x in arrow_area_up.get_overlapping_areas():
					if found_bullet_up == false:
						if BattleManager.battle_enemy.bullets.find(x) != -1:
							x.on_hit()
							hit_note_player.play()
							found_bullet_up = true
				if found_bullet_up == false:
					recieve_damage(spam_prevention_damage)
		if event.is_action_released("UpArrow"):
			if is_players_turn == false:
				arrow_sprite_up.frame = 0

		if event.is_action_pressed("DownArrow"):
			if is_players_turn == false:
				arrow_sprite_down.frame = 1
				found_bullet_down = false
				for x in arrow_area_down.get_overlapping_areas():
					if found_bullet_down == false:
						if BattleManager.battle_enemy.bullets.find(x) != -1:
							x.on_hit()
							hit_note_player.play()
							found_bullet_down = true
				if found_bullet_down == false:
					recieve_damage(spam_prevention_damage)
		if event.is_action_released("DownArrow"):
			if is_players_turn == false:
				arrow_sprite_down.frame = 0

		if event.is_action_pressed("RightArrow"):
			if is_players_turn == false:
				arrow_sprite_right.frame = 1
				found_bullet_right = false
				for x in arrow_area_right.get_overlapping_areas():
					if found_bullet_right == false:
						if BattleManager.battle_enemy.bullets.find(x) != -1:
							x.on_hit()
							hit_note_player.play()
							found_bullet_right = true
				if found_bullet_right == false:
					recieve_damage(spam_prevention_damage)
		if event.is_action_released("RightArrow"):
			if is_players_turn == false:
				arrow_sprite_right.frame = 0

		if event.is_action_pressed("LeftArrow"):
			if is_players_turn == false:
				arrow_sprite_left.frame = 1
				found_bullet_left = false
				for x in arrow_area_left.get_overlapping_areas():
					if found_bullet_left == false:
						if BattleManager.battle_enemy.bullets.find(x) != -1:
							x.on_hit()
							hit_note_player.play()
							found_bullet_left = true
				if found_bullet_left == false:
					recieve_damage(spam_prevention_damage)
		if event.is_action_released("LeftArrow"):
			if is_players_turn == false:
				arrow_sprite_left.frame = 0


func play_turn():
	is_players_turn = true
	arrow_sprite_up.frame = 0
	arrow_sprite_down.frame = 0
	arrow_sprite_left.frame = 0
	arrow_sprite_right.frame = 0
	if BattleManager.battle_ui != null: BattleManager.battle_ui.show_ui()
	
func end_turn():
	is_players_turn = false
	if BattleManager.battle_ui != null: BattleManager.battle_ui.hide_ui()
	get_parent().turn_end()

func attack_knife():
	calculate_damage("knife")
	damage_enemy(damage_to_apply)
	end_turn()

func attack_magic():
	calculate_damage("magic")
	damage_enemy(damage_to_apply)
	end_turn()

func attack_punch():
	calculate_damage("punch")
	damage_enemy(damage_to_apply)
	end_turn()

func calculate_damage(attack_type):
	if attack_type == "knife":
		damage_to_apply = 1
	if attack_type == "magic":
		damage_to_apply = 1
	if attack_type == "punch":
		damage_to_apply = 1

func damage_enemy(damage):
	BattleManager.battle_enemy.health = clamp(BattleManager.battle_enemy.health - damage, 0, BattleManager.battle_enemy.health)
	BattleManager.battle_camera.screenshake(1, .5, 0)
	attack_audio_player.play()

func recieve_damage(damage):
	health = clamp(health - damage, 0, health)
	BattleManager.battle_camera.screenshake(1, .5, 0)
	damage_audio_player.play()

func heal_damage(heal_damage):
	print(heal_damage)
	health = clamp(health + heal_damage, 0, health_max)
	heal_audio_player.play()
