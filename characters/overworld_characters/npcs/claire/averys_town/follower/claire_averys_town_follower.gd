extends KinematicBody2D


# Variables
var velocity = Vector2()
var acceleration = float(50)
var friction = float(35)
var max_speed = float(75)
var path = PoolVector2Array()
var moving_direction = Vector2()
var moving = bool(false)

onready var sprite = $Sprite
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")


func _ready():
	animation_tree.active = true
	animation_tree.set("parameters/Idle/blend_position", Vector2.DOWN)
	Global.player.follower = self


func _physics_process(delta):
	if moving == true:
		moving_direction = (Global.player.global_position - global_position).normalized()
		velocity = velocity.move_toward(moving_direction * max_speed, acceleration * delta * Global.target_fps)
		animation_tree.set("parameters/Idle/blend_position", moving_direction)
		animation_tree.set("parameters/Walk/blend_position", moving_direction)
		animation_state.travel("Walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta * Global.target_fps)
		animation_state.travel("Idle")

	if (global_position - Global.player.global_position).length() < 35:
		moving = false
	else:
		moving = true

	velocity = move_and_slide(velocity)
