extends Node


var pending_door_repos = bool(false)
var exit_door


func enter_door(level_path, exit_door_name):
	exit_door = exit_door_name
	Global.player.level_transition.fade_in()
	Global.player.loading_new_scene = true
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene(level_path)
	pending_door_repos = true

func _physics_process(delta):
	if pending_door_repos == true:
		var door = get_tree().get_current_scene().get_node(exit_door)
		if door != null:
			pending_door_repos = false
			Global.player.position = door.exit_location.global_position
			Global.player.set_facing_direction(door.facing_direction)
			Global.player.loading_new_scene = false
			Global.on_scene_loaded()
