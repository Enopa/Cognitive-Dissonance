extends KinematicBody2D


var start_dialog_id = "FriendsCutsceneIntroDialog"
var end_dialog_id = "FriendsCutsceneDialog"

var cutscene_id = String("FriendsCutscene")

# Variables
var velocity = Vector2()
var acceleration = float(50)
var friction = float(35)
var max_speed = float(75)
var moving = bool(false)
var moving_direction = Vector2()
var target = Vector2(608, 176)
var at_location = bool(false)

onready var sprite = $Sprite
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")


signal cutscene_finished


func _ready():
	animation_tree.active = true
	animation_tree.set("parameters/Idle/blend_position", Vector2.UP)
	var dialog = Dialogic.start(start_dialog_id)
	add_child(dialog)
	Global.player.talk()
	dialog.connect("timeline_end", self, "after_intro_dialog")


func _physics_process(delta):
	if moving == true:
		moving_direction = (target - global_position).normalized()
		velocity = velocity.move_toward(moving_direction * max_speed, acceleration * delta * Global.target_fps)
		animation_tree.set("parameters/Idle/blend_position", moving_direction)
		animation_tree.set("parameters/Walk/blend_position", moving_direction)
		animation_state.travel("Walk")
		if (global_position - target).length() < 1:
			moving = false
			at_location = true
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta * Global.target_fps)
		animation_state.travel("Idle")
		animation_tree.set("parameters/Idle/blend_position", Vector2.UP)

	velocity = move_and_slide(velocity)
	Global.player.position = position

	if at_location == true and velocity == Vector2(0, 0):
		Global.player.animation_tree.set("parameters/Idle/blend_position", Vector2.UP)
		end_dialog()
		at_location = false


func end_dialog():
	yield(get_tree().create_timer(.5), "timeout")
	var dialog = Dialogic.start(end_dialog_id)
	add_child(dialog)
	Global.player.talk()
	dialog.connect("timeline_end", self, "after_dialog")


func after_intro_dialog(timeline_name):
	yield(get_tree().create_timer(.1), "timeout")
	Global.player.stop_talking()
	moving = true

func after_dialog(timeline_name):
	yield(get_tree().create_timer(.1), "timeout")
	Global.player.exit_movement_cutscene()
	Global.player.exit_cutscene()
	Global.player.stop_talking()
	CompletionManager.completed_cutscene_ids.append(cutscene_id)
	emit_signal("cutscene_finished")
	queue_free()
