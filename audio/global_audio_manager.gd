extends Node2D


onready var stream_player = $AudioStreamPlayer
var audio_path = String("")


func set_track(track_path):
	if track_path == String(""):
		stop_track()
	else:
		if audio_path != track_path:
			audio_path = track_path
			var audio_loaded = load(audio_path)
			stream_player.stream = audio_loaded
			stream_player.play()

func stop_track():
	stream_player.stop()
	audio_path = null
