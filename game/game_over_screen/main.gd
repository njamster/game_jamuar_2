extends CanvasLayer


func _ready() -> void:
	EventBus.game_over.connect(_on_game_over)
	get_tree().paused = false
	Global.reset()
	self.hide()


func _on_game_over(reason : String) -> void:
	get_tree().paused = true
	%Score.text = "Score: %d" % Global.enemies_killed
	%Reason.text = "[center]" + reason + "[/center]"
	self.show()

	var tween := create_tween().set_loops()
	tween.tween_property(%PressToRetry, "modulate:a", 0.1, 0.7)
	tween.tween_property(%PressToRetry, "modulate:a", 1.0, 0.7)


func _input(event: InputEvent) -> void:
	if Input.is_joy_button_pressed(event.device, JOY_BUTTON_START) and \
		Input.is_joy_button_pressed(event.device, JOY_BUTTON_BACK):
			get_tree().reload_current_scene()
