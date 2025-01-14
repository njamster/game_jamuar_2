extends Node2D


@export var RANDOM_STARTING_PLAYER := true


func spawn() -> void:
	for i in Global.PLAYER_COUNT:
		var player := preload("player/main.tscn").instantiate()
		player.id = i
		player.name = "Player%d" % (i+1)
		match player.id:
			0:
				player.position.y = -320
			1:
				player.position.y = +320
			2:
				player.position.x = +320
			3:
				player.position.x = -320
		player.throw_to_player.connect(_on_throw_to_player)
		add_child(player)

	assign_starting_player()

	EventBus.introduction_finished.emit()


func assign_starting_player() -> void:
	var starting_player_id := 0
	if RANDOM_STARTING_PLAYER:
		starting_player_id = randi_range(0, Global.PLAYER_COUNT -1)
	get_child(starting_player_id).has_ball = true


func _on_throw_to_player(thrower_id : int, target_id : int) -> void:
	if target_id >= Global.PLAYER_COUNT:
		return

	var thrower := get_node_or_null("Player%s" % (thrower_id+1))
	var target := get_node_or_null("Player%s" % (target_id+1))

	if thrower == null or target == null:
		return

	var ball := preload("player/ball/main.tscn").instantiate()
	ball.global_position = thrower.global_position
	ball.target = target
	add_child(ball)

	thrower.has_ball = false

	SoundManager.play_sound_effect("throw")
