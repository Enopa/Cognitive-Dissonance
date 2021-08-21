extends "res://characters/battle_characters/battle_enemy/battle_enemy.gd"


# Attack Data
func _init():
	bullet_time = float(0.5)
	bullet_count = float(8)
	bullet_speed = float(2)
	bullet_damage = int(2)
	doubles_chance = float(0)
	music_path = String("res://audio/music/battle_arena/test_fight_track_1/test_fight_track_1.wav")
