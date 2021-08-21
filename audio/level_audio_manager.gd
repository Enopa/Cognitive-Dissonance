extends Node2D


export var music_track_path = String("")

func _ready():
	GlobalAudioManager.set_track(music_track_path)
