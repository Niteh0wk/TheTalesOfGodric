extends Node


var music_player : AudioStreamPlayer

func _ready():
	music_player = $AudioStreamPlayer
	if music_player == null:
		print("Error: AudioStreamPlayer2d node not found")
	else:
		if not music_player.playing:
			music_player.play()
