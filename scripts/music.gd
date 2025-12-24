extends AudioStreamPlayer2D

var currently_playing = true

func _process(_delta):
	if Input.is_action_just_pressed("mute"):
		currently_playing = !currently_playing
		playing = currently_playing
