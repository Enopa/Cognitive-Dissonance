extends Node


var player_pos = Vector2(0, 0)
var overworld_scene_path = String("")
var pending_battle_exit_repos = bool(false)
var pending_spawn_enemy = bool(false)
var battle_scene_path = String("res://levels/battle_arena/battle_arena.tscn")
var current_enemy_path = String("")
var current_battle_id = String("")

signal finished_battle

func enter_battle(enemy_path, battle_id):
	player_pos = Global.player.position
	current_battle_id = battle_id
	overworld_scene_path = get_tree().current_scene.filename
	GlobalAudioManager.stop_track()
	Global.player.loading_new_scene = true
	Global.player.level_transition.fade_in()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene(battle_scene_path)
	BattleManager.in_battle = true
	current_enemy_path = enemy_path
	pending_spawn_enemy = true

func restart_battle():
	BattleManager.death_screen.level_transition.fade_in()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene(battle_scene_path)
	BattleManager.in_battle = true
	pending_spawn_enemy = true

func exit_battle():
	BattleManager.win_screen.level_transition.fade_in()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene(overworld_scene_path)
	pending_battle_exit_repos = true

func _physics_process(delta):
	if pending_battle_exit_repos == true and Global.player != null:
		pending_battle_exit_repos = false
		Global.player.position = player_pos
		emit_signal("finished_battle")

	if pending_spawn_enemy == true:
		var enemy_spawner = get_tree().get_current_scene().get_node("TurnQueue").get_node("BattleCharacterSpawner")
		if enemy_spawner != null:
			pending_spawn_enemy = false
			enemy_spawner.spawn_enemy(current_enemy_path)
