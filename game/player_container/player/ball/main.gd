extends Area2D


@export var target : Node:
	set(value):
		if target == value:
			return

		target = value

		process_mode = PROCESS_MODE_INHERIT

var move_speed := 900


func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		var move_direction := global_position.direction_to(target.global_position)
		global_position += move_direction * move_speed * delta
	else:
		EventBus.game_over.emit("You dropped the ball, dimwit!")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		if body == target:
			body.has_ball = true
			SoundManager.play_sound_effect("catch")
			queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		area.kill()
