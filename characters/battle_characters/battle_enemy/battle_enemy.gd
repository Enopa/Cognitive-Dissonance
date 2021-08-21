extends "res://characters/battle_characters/battle_character_base.gd"


# Fight Data
var bullet_time = float(0.5)
var bullet_count = float(8)
var bullet_speed = float(1.5)
var bullet_damage = int(2)
var doubles_chance = float(0)
var music_path = String("")

var bullet_scene = preload("res://characters/battle_characters/battle_enemy/bullets/bullet.tscn")
var bullets = Array()
var took_turn = bool(false)


# Func ready
func _ready():
	BattleManager.battle_enemy = self
	GlobalAudioManager.set_track(music_path)


# Func process
func _process(delta):
	if took_turn == true and bullets.size() <= 0:
		end_turn()


func play_turn():
	for number in range(bullet_count):
		fire_bullet()
		yield(get_tree().create_timer(bullet_time), "timeout")
	took_turn = true

func end_turn():
	took_turn = false
	get_parent().turn_end()


func fire_bullet():
	if BattleManager.bullet_spawners.empty() == false:
		var execution_times = int(1)
		if rand_range(0, 1) <= doubles_chance: execution_times = 2
		for x in execution_times:
			BattleManager.bullet_spawners[randi() % BattleManager.bullet_spawners.size()].spawn_bullet(bullet_damage, bullet_speed)
