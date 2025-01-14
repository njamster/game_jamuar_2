extends Control


func _ready() -> void:
	$Players.spawn()


func _input(event: InputEvent) -> void:
	if Input.is_joy_button_pressed(event.device, JOY_BUTTON_START) and \
		Input.is_joy_button_pressed(event.device, JOY_BUTTON_BACK):
			get_tree().reload_current_scene()
