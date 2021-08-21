extends Node2D


onready var player_hp_value = $PlayerHPValue
onready var enemy_hp_value = $EnemyHPValue


func _process(delta):
	if BattleManager.battle_enemy != null and BattleManager.battle_player != null:
		player_hp_value.text = String(BattleManager.battle_player.health)
		enemy_hp_value.text = String(BattleManager.battle_enemy.health)
