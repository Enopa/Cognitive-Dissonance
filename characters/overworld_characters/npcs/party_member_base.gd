extends KinematicBody2D


# Variables
var velocity = Vector2()
var acceleration = float(100)
var friction = float(35)
var max_speed = float(150)
var moving_direction = Vector2()
var initial_move = bool(true)
var last_pos = Vector2()
var party_member_index = int(0)
var party_member_distance = int(20)

onready var sprite = $Sprite
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")


func _ready():
	animation_tree.active = true
	animation_tree.set("parameters/Idle/blend_position", Vector2.DOWN)
	initial_move = true

func _physics_process(delta):
	
	party_member_index = Global.player.party.find(self, 0)
	
	# Initial movement lerp to player
	if initial_move == true:
		if Global.player.movement_path.size() > party_member_distance * (party_member_index + 1):
			moving_direction = (Global.player.movement_path[party_member_distance * (party_member_index + 1)] - global_position).normalized()
			velocity = velocity.move_toward(moving_direction * max_speed, acceleration * delta * Global.target_fps)
			if (global_position - Global.player.movement_path[party_member_distance * (party_member_index + 1)]).length() < 1:
				initial_move = false
			velocity = move_and_slide(velocity)
			animation_tree.set("parameters/Idle/blend_position", moving_direction)
			animation_tree.set("parameters/Walk/blend_position", moving_direction)
			animation_state.travel("Walk")
	
	# Follow player logic
	else:
		moving_direction = (Global.player.global_position - global_position).normalized()
		if Global.player.movement_path.size() > party_member_distance * (party_member_index + 1):
			position = Global.player.movement_path[party_member_distance * (party_member_index + 1)]
		if last_pos != position:
			animation_tree.set("parameters/Idle/blend_position", moving_direction)
			animation_tree.set("parameters/Walk/blend_position", moving_direction)
			animation_state.travel("Walk")
		else:
			animation_state.travel("Idle")
	last_pos = position
