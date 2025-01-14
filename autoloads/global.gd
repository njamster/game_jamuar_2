extends Node


var PLAYER_COUNT := 4:
	set(value):
		if PLAYER_COUNT == value:
			return

		PLAYER_COUNT = clamp(value, 2, 4)

var players_alive := PLAYER_COUNT:
	set(value):
		if players_alive == value:
			return

		players_alive = clamp(value, 1, PLAYER_COUNT)

		if players_alive == 1:
			EventBus.game_over.emit("You can't play this game alone. Sorry!")

var enemies_killed := 0:
	set(value):
		if enemies_killed == value:
			return

		enemies_killed = max(value, 0)


func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func reset() -> void:
	players_alive = PLAYER_COUNT
	enemies_killed = 0
