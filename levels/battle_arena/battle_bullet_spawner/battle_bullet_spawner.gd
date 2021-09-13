extends Node


export var direction = String("")
var bullet_scene = preload("res://levels/battle_arena/bullets/bullet.tscn")


# Func ready
func _ready():
	BattleManager.bullet_spawners.append(self)
	if direction == "Up":
		BattleManager.bullet_spawner_up = self
	if direction == "Down":
		BattleManager.bullet_spawner_down = self
	if direction == "Left":
		BattleManager.bullet_spawner_left = self
	if direction == "Right":
		BattleManager.bullet_spawner_right = self


func spawn_bullet(damage, speed, damage_bullet_damage, heal_bullet_health, type):
	var bullet_scene_instance = bullet_scene.instance()
	BattleManager.battle_enemy.bullets.append(bullet_scene_instance)
	bullet_scene_instance.speed = speed
	if type == "Damage":
		bullet_scene_instance.damage = damage_bullet_damage
	elif type == "Heal":
		bullet_scene_instance.damage = heal_bullet_health
	else:
		bullet_scene_instance.damage = damage
	bullet_scene_instance.type = type
	if direction == "Up": bullet_scene_instance.rotation_degrees = 90
	if direction == "Right": bullet_scene_instance.rotation_degrees = 180
	if direction == "Down": bullet_scene_instance.rotation_degrees = -90
	if direction == "Left": bullet_scene_instance.rotation_degrees = 0
	add_child(bullet_scene_instance)
