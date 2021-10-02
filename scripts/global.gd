extends Node

const target_fps = int(60)
const save_dir = "user://saves/"
var save_path = save_dir + "save.dat"
var loaded_data
var load_pending = bool(false)

# Nodes
var player
var navigation

# Party
var party_positions = []
var party_paths = []

signal loaded_scene


func save_data():

	# Set Save Data
	var save_data_dictionary = {
	"room_path": get_tree().current_scene.filename,
	"player_position": player.position,
	"player_follower_paths": party_paths,
	"player_follower_positions": party_positions,
	"completed_battle_ids": CompletionManager.completed_battle_ids,
	"completed_cutscene_ids": CompletionManager.completed_cutscene_ids
	}

	# Create Save Directory
	var dir = Directory.new()
	if !dir.dir_exists(save_dir):
		dir.make_dir_recursive(save_dir)

	var save_file = File.new()
	var error = save_file.open(save_path, File.WRITE)
	if error == OK:
		save_file.store_var(save_data_dictionary)
		save_file.close()

func load_data():

	# Load Save Data
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var data = file.get_var()
			file.close()

			# Apply Loaded Data
			loaded_data = data
			get_tree().change_scene(loaded_data.room_path)
			apply_loaded_data_to_singletons()
			load_pending = true

func apply_loaded_data_to_singletons():
	CompletionManager.completed_battle_ids = loaded_data.completed_battle_ids
	CompletionManager.completed_cutscene_ids = loaded_data.completed_cutscene_ids

func apply_loaded_data():
	player.position = loaded_data.player_position
	for item in loaded_data.player_follower_paths:
		var index = loaded_data.player_follower_paths.find(item, 0)
		player.follow_player(item, loaded_data.player_follower_positions[index])
	emit_signal("loaded_scene")

func _process(delta):
	if load_pending == true and player != null:
		load_pending = false
		apply_loaded_data()

func on_scene_loaded():
	emit_signal("loaded_scene")


# Input
func _input(event):

	# Interacting
	if event.is_action_pressed("QuickSave"):
		save_data()
	if event.is_action_pressed("QuickLoad"):
		load_data()

	# Quiting
	if event.is_action_pressed("Quit"):
		get_tree().quit()
