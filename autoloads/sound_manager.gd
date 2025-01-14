extends Node


func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS


func play_sound_effect(sound_name : String) -> void:
	var player := AudioStreamPlayer.new()
	match sound_name:
		"throw":
			player.stream = preload("res://sounds/throw.mp3")
		"catch":
			player.stream = preload("res://sounds/catch.mp3")
		"smash":
			player.stream = preload("res://sounds/smash.mp3")
		"explode":
			player.stream = preload("res://sounds/explode.mp3")
	add_child(player)
	player.finished.connect(player.queue_free)
	player.pitch_scale = randf_range(0.9, 1.1)
	player.play()
