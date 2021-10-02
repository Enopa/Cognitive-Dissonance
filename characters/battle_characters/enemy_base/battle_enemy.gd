extends "res://characters/battle_characters/battle_character_base.gd"


# Fight Data
export var bullet_count = float(8)
export var bullet_speed = float(1.25)
export var bullet_damage = int(1)
export var damage_bullet_damage = int(2)
export var heal_bullet_health = int(5)
export var damage_note_chance = float(0)
export var heal_note_chance = float(0)
export var music_path = String("")

var bullets = Array()
var took_turn = bool(false)
var bullets_fired = int(0)
var pending_turn_end = bool(false)

onready var midi_player = $MIDIPlayer


# Func ready
func _ready():
	BattleManager.battle_enemy = self
	midi_player.play()
	yield(get_tree().create_timer(131 / (bullet_speed * 60)), "timeout")
	GlobalAudioManager.set_track(music_path)


# Func process
func _process(delta):
	if pending_turn_end == true and bullets.size() <= 0:
		end_turn()
	if bullets_fired >= bullet_count:
		pending_turn_end = true


func play_turn():
	if health > 0:
		bullets_fired = 0
		pending_turn_end = false
		took_turn = true

func end_turn():
	bullets_fired = 0
	took_turn = false
	pending_turn_end = false
	get_parent().turn_end()


func fire_bullet(direction):
	if BattleManager.bullet_spawners.empty() == false:
		if direction == "Up":
			BattleManager.bullet_spawner_up.spawn_bullet(bullet_damage, bullet_speed, damage_bullet_damage, heal_bullet_health, get_bullet_type())
		if direction == "Down":
			BattleManager.bullet_spawner_down.spawn_bullet(bullet_damage, bullet_speed, damage_bullet_damage, heal_bullet_health, get_bullet_type())
		if direction == "Left":
			BattleManager.bullet_spawner_left.spawn_bullet(bullet_damage, bullet_speed, damage_bullet_damage, heal_bullet_health, get_bullet_type())
		if direction == "Right":
			BattleManager.bullet_spawner_right.spawn_bullet(bullet_damage, bullet_speed, damage_bullet_damage, heal_bullet_health, get_bullet_type())
		bullets_fired += 1

func get_bullet_type():
	if rand_range(0, 1) <= heal_note_chance: return String("Heal")
	elif rand_range(0, 1) <= damage_note_chance: return String("Damage")
	else: return String("Default")


func _on_MIDIPlayer_midi_event(channel, event):
	if took_turn == true:
		if event.type == 1:
			if bullets_fired < bullet_count:
				var direction = set_bullet_direction(event)
				fire_bullet(direction)

func set_bullet_direction(event):
	var direction = String()
	var current_assigned_dir_index = int()
	for i in event.note:
		if current_assigned_dir_index == 0:
			direction = "Up"
		if current_assigned_dir_index == 1:
			direction = "Up"
		if current_assigned_dir_index == 2:
			direction = "Down"
		if current_assigned_dir_index == 3:
			direction = "Down"
		if current_assigned_dir_index == 4:
			direction = "Left"
		if current_assigned_dir_index == 5:
			direction = "Left"
		if current_assigned_dir_index == 6:
			direction = "Right"
		if current_assigned_dir_index == 7:
			direction = "Right"
			current_assigned_dir_index = 0
		current_assigned_dir_index += 1
	return(direction)
