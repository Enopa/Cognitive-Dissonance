extends Node


var death_level_path = "res://levels/death_level/death_level.tscn"
var battle_win_path = String("res://levels/win_level/win_level.tscn")
var player_killed = bool(false)
var enemy_killed = bool(false)
var in_battle = bool(false)

# Nodes
var battle_ui
var battle_camera
var battle_player
var battle_enemy
var bullet_spawners = Array()
var bullet_spawner_up
var bullet_spawner_down
var bullet_spawner_left
var bullet_spawner_right
var battle_arena
var death_screen
var win_screen


func _process(delta):
	if battle_player != null:
		if battle_player.health <= 0: on_player_killed()
	if battle_enemy != null:
		if battle_enemy.health <= 0: on_enemy_killed()


func on_player_killed():
	battle_enemy.midi_player.stop()
	player_killed = true
	battle_player.dead = true
	battle_camera.level_transition.fade_in()
	clear_nodes()
	in_battle = false
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene(death_level_path)

func on_enemy_killed():
	battle_enemy.midi_player.stop()
	enemy_killed = true
	battle_enemy.dead = true
	battle_camera.level_transition.fade_in()
	clear_nodes()
	in_battle = false
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene(battle_win_path)

func clear_nodes():
	battle_ui = null
	battle_camera = null
	battle_player = null
	battle_enemy = null
	bullet_spawners = Array()
	battle_arena = null
