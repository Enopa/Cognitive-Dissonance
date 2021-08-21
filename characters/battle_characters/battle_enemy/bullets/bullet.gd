extends Area2D


var damage = int(2)
var speed = float(1.5)
var lifetime = int(4)
onready var visibility_notifier = $VisibilityNotifier2D


func _ready():
	yield(get_tree().create_timer(lifetime), "timeout")
	kill_self()


func _physics_process(delta):
	position += Vector2(speed, 0).rotated(rotation)


func _on_Bullet_area_entered(area):
	if BattleManager.battle_player != null:
		for x in get_overlapping_areas():
			if x == BattleManager.battle_player.hurtbox_area:
				BattleManager.battle_player.recieve_damage(damage)
				kill_self()

func kill_self():
	BattleManager.battle_enemy.bullets.erase(self)
	queue_free()
