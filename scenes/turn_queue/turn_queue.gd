extends Node2D
class_name TurnQueue


var active_character


func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	start()


func start():
	initialise()
	play_turn()


func initialise():
	active_character = get_child(0)


func play_turn():
	active_character.play_turn()


func turn_end():
	var new_index = int(active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	play_turn()
