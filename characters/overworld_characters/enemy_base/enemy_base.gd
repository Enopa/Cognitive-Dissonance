extends KinematicBody2D


export var enemy_path = String("")
export var battle_id = String("")

enum {
	idle,
	wander,
	chase
}

var state = idle


# Variables
var velocity = Vector2()
var acceleration = float(50)
var friction = float(35)
var max_speed = float(75)
var moving_direction = Vector2()
var player_detected = bool(false)


onready var sprite = $Sprite


func _ready():
	Global.connect("loaded_scene", self, "on_loaded")
	if CompletionManager.completed_battle_ids.find(battle_id) != -1:
		queue_free()


func on_loaded():
	if CompletionManager.completed_battle_ids.find(battle_id) != -1:
		queue_free()


func _physics_process(delta):

	match state:
		
		idle:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta * Global.target_fps)

		chase:
			moving_direction = (Global.player.global_position - global_position).normalized()
			velocity = velocity.move_toward(moving_direction * max_speed, acceleration * delta * Global.target_fps)
			sprite.flip_h = velocity.x < 0

	velocity = move_and_slide(velocity)


func _on_PlayerDetectionArea_body_entered(body):
	player_detected = true
	state = chase


func _on_PlayerDetectionArea_body_exited(body):
	player_detected = false


func _on_BattleTriggerArea_body_entered(body):
	if body == Global.player:
		BattleTransitionManager.enter_battle(enemy_path, battle_id)
		CompletionManager.completed_battle_ids.append(battle_id)
