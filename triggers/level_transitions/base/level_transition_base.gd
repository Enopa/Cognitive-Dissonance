extends Node2D


export var level_path = String("")
export var exit_door_name = String("")
export var facing_direction = Vector2()
export var locked = bool(false)
onready var exit_location = $ExitLocation


func _on_Area2D_body_entered(body):
	if locked == false:
		DoorManager.enter_door(level_path, exit_door_name)
