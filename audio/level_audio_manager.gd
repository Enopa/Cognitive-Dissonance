extends Node2D


export var music_track_path = String("")
export var enabled = bool(true)


func _ready():
	if enabled == true:
		GlobalAudioManager.set_track(music_track_path)
