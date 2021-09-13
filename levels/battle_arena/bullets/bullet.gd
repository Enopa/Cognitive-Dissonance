extends Area2D


var type = String("Default")
var damage = int(2)
var speed = float(1.5)
var lifetime = int(4)
var switch_first_stage = bool(true)
onready var sprite = $Sprite

func _ready():
	if type == "Heal":
		sprite.self_modulate = Color(0, 200, 0, 255)
	if type == "Damage":
		sprite.self_modulate = Color(200, 0, 0, 255)


func _physics_process(delta):
	position += Vector2(speed, 0).rotated(rotation)


func _on_Bullet_area_entered(area):
	if BattleManager.battle_player != null:
		for x in get_overlapping_areas():
			if x == BattleManager.battle_player.hurtbox_area:
				if type != "Damage":
					BattleManager.battle_player.recieve_damage(damage)
					kill_self()
				kill_self()

func kill_self():
	BattleManager.battle_enemy.bullets.erase(self)
	queue_free()

func on_hit():
	if type == "Default":
		kill_self()
	if type == "Heal":
		BattleManager.battle_player.heal_damage(damage)
		kill_self()
	if type == "Damage":
		BattleManager.battle_player.recieve_damage(damage)
		kill_self()
	
