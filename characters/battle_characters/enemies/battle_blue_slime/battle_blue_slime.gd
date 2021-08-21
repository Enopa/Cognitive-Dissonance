extends "res://characters/battle_characters/battle_enemy/battle_enemy.gd"


# Attack Data
func _init():
	bullet_time = float(.25)
	bullet_count = float(16)
	bullet_speed = float(3.5)
	bullet_damage = int(5)
	doubles_chance = float(0.1)
	music_path = String("res://audio/music/battle_arena/test_fight_track_1/test_fight_track_1.wav")
