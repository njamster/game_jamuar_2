extends CenterContainer


func _ready() -> void:
	$VBox/PlayerCount/Two.grab_focus()


func start_game(player_count : int) -> void:
	Global.PLAYER_COUNT = player_count
	get_tree().change_scene_to_file("res://game/main.tscn")
