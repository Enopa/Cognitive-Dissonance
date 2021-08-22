extends Node2D


var opening_level_path = String("res://levels/opening_level/opening_level.tscn")


# Input
func _input(event):

	# Interacting
	if event.is_action_pressed("Interact"):
		start_game()


func start_game():
	var file = File.new()
	if file.file_exists(Global.save_path):
		var error = file.open(Global.save_path, File.READ)
		if error == OK:
			var data = file.get_var()
			file.close()

			# Apply Loaded Data
			Global.loaded_data = data
			Global.apply_loaded_data_to_singletons()
			get_tree().change_scene(data.room_path)
			Global.load_data()
	else:
		get_tree().change_scene(opening_level_path)
	
