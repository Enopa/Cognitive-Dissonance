extends KinematicBody2D


# Variables
var velocity = Vector2()
var acceleration = float(50)
var friction = float(35)
var max_speed = float(75)

# Player State Variables
var interact_array = []
var loading_new_scene = bool(false)
var found_interactable = false

# Cutscenes
var cutscene_instance
var talking = bool(false)
var in_cutscene = bool(false)
var in_movement_cutscene = bool(false)
var follower
var follower_path = String()
var follower_position = Vector2()

# Onready Animation
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var level_transition = $PlayerCamera/LevelTransition
onready var player_camera = $PlayerCamera

# Onready Collision
onready var interaction_area = $InteractionArea
onready var interaction_collision = $InteractionArea/CollisionShape2D


# Func ready
func _ready():
	animation_tree.active = true
	Global.player = self
	animation_tree.set("parameters/Idle/blend_position", Vector2(0, 1))
	update_interaction_collision()

# Func Physics Process
func _physics_process(delta):

	# Walking
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("WalkRight") - Input.get_action_strength("WalkLeft")
	input_vector.y = Input.get_action_strength("WalkDown") - Input.get_action_strength("WalkUp")

	if input_vector != Vector2.ZERO and can_move():
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta * Global.target_fps)
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Walk/blend_position", input_vector)
		animation_state.travel("Walk")
		update_interaction_collision()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta * Global.target_fps)
		animation_state.travel("Idle")

	if follower != null:
		follower_position = follower.position

	velocity = move_and_slide(velocity)


# Input
func _input(event):

	# Interacting
	if event.is_action_pressed("Interact"):
		found_interactable = false
		if can_interact() == true:
			for x in interaction_area.get_overlapping_bodies():
				if found_interactable == false:
					if x.is_in_group("Interactable"):
						print("test")
						x.on_interacted()
						found_interactable = true


# Functions

# Talk
func talk():
	talking = true
	velocity.x = 0

# Stop Talking
func stop_talking():
	talking = false

# Enter Cutscene
func enter_cutscene():
	in_cutscene = true
	velocity.x = 0

# Exit Cutscene
func exit_cutscene():
	in_cutscene = false

# Enter Movement Cutscene
func enter_movement_cutscene(cutscene_path):
	in_movement_cutscene = true
	velocity.x = 0
	visible = false
	var loaded_cutscene = load(cutscene_path)
	cutscene_instance = loaded_cutscene.instance()
	cutscene_instance.position = position
	get_parent().add_child(cutscene_instance)
	return(cutscene_instance)

# Exit Movement Cutscene
func exit_movement_cutscene():
	in_movement_cutscene = false
	visible = true
	cutscene_instance.queue_free()

# Follow Player
func follow_player(new_follower_path, new_follower_position):
	var loaded_follower = load(new_follower_path)
	var follower_instance = loaded_follower.instance()
	follower_instance.position = new_follower_position
	get_parent().add_child(follower_instance)
	follower = follower_instance
	follower_path = follower.get_filename()
	follower_position = follower.position

# Stop Following Player
func stop_following_player():
	follower = null

# Can Move
func can_move():
	return(talking == false and loading_new_scene == false and in_cutscene == false and in_movement_cutscene == false)

# Can Interact
func can_interact():
	return(talking == false and loading_new_scene == false and in_cutscene == false and in_movement_cutscene == false)
 
# Update Interaction Collision
func update_interaction_collision():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("WalkRight") - Input.get_action_strength("WalkLeft")
	input_vector.y = Input.get_action_strength("WalkDown") - Input.get_action_strength("WalkUp")
	if input_vector == Vector2(0, 1):
		interaction_collision.rotation_degrees = 0
	elif input_vector == Vector2(0, -1):
		interaction_collision.rotation_degrees = 180
	elif input_vector == Vector2(1, 0):
		interaction_collision.rotation_degrees = -90
	elif input_vector == Vector2(1, 1):
		interaction_collision.rotation_degrees = -90
	elif input_vector == Vector2(1, -1):
		interaction_collision.rotation_degrees = -90
	elif input_vector == Vector2(-1, 0):
		interaction_collision.rotation_degrees = 90
	elif input_vector == Vector2(-1, 1):
		interaction_collision.rotation_degrees = 90
	elif input_vector == Vector2(-1, -1):
		interaction_collision.rotation_degrees = 90

# Set Facing Direction
func set_facing_direction(direction):
	animation_tree.set("parameters/Idle/blend_position", direction)
	update_interaction_collision()
