extends Node


export var direction = String("")
var bullet_scene = preload("res://characters/battle_characters/battle_enemy/bullets/bullet.tscn")


# Func ready
func _ready():
	BattleManager.bullet_spawners.append(self)


func spawn_bullet(damage, speed):
	var bullet_scene_instance = bullet_scene.instance()
	add_child(bullet_scene_instance)
	BattleManager.battle_enemy.bullets.append(bullet_scene_instance)
	bullet_scene_instance.speed = speed
	bullet_scene_instance.damage = damage
	if direction == "Up": bullet_scene_instance.rotation_degrees = 90
	if direction == "Right": bullet_scene_instance.rotation_degrees = 180
	if direction == "Down": bullet_scene_instance.rotation_degrees = -90
	if direction == "Left": bullet_scene_instance.rotation_degrees = 0
