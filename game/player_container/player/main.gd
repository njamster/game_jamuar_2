extends CharacterBody2D


signal throw_to_player(thrower_id, target_id)


@export var id := -1:
	set(value):
		if id == value:
			return

		id = value

		match id:
			0: # Orange
				$Sprite.modulate = Color("#FEB504")
				$DeathExplosion.color = Color("#FEB504")
			1: # Greem
				$Sprite.modulate = Color("#7DB700")
				$DeathExplosion.color = Color("#7DB700")
			2: # Red
				$Sprite.modulate = Color("#EF4E29")
				$DeathExplosion.color = Color("#EF4E29")
			3: # Blue
				$Sprite.modulate = Color("#009FEB")
				$DeathExplosion.color = Color("#009FEB")

var move_direction := Vector2.ZERO
var move_speed := 300.0
var has_ball := false:
	set(value):
		if has_ball == value:
			return

		has_ball = value

		$Hint.visible = not has_ball

var can_move := false


func _ready() -> void:
	$DeathExplosion.emitting = false

	EventBus.tutorial_finished.connect(_on_tutorial_finished)


func _on_tutorial_finished() -> void:
	can_move = true


func kill() -> void:
	$Hint.hide()
	$Sprite.hide()
	can_move = false
	$Hitbox.set_deferred("disabled", true)
	Global.players_alive -= 1
	EventBus.player_died.emit()
	$DeathExplosion.emitting = true
	SoundManager.play_sound_effect("explode")
	await $DeathExplosion.finished
	if has_ball:
		EventBus.game_over.emit("You [i]really[/i] shouldn't die with the ball!")
	queue_free()


func _physics_process(_delta: float) -> void:
	if can_move:
		velocity = move_direction * move_speed
		move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventJoypadMotion or event is InputEventJoypadButton):
		return

	if event.device != self.id:
		return

	if event is InputEventJoypadMotion:
		if event.axis in [JOY_AXIS_LEFT_X, JOY_AXIS_LEFT_Y]:
			move_direction = Vector2(
				Input.get_joy_axis(self.id, JOY_AXIS_LEFT_X),
				Input.get_joy_axis(self.id, JOY_AXIS_LEFT_Y),
			)
			if move_direction.length() < 0.5:
				move_direction = Vector2.ZERO

	if event is InputEventJoypadButton:
		if has_ball:
			if self.id in [1, 2, 3] and event.is_action_pressed("throw_to_player1"):
				throw_to_player.emit(self.id, 0)
			elif self.id in [0, 2, 3] and event.is_action_pressed("throw_to_player2"):
				throw_to_player.emit(self.id, 1)
			elif self.id in [0, 1, 3] and event.is_action_pressed("throw_to_player3"):
				throw_to_player.emit(self.id, 2)
			elif self.id in [0, 1, 2] and event.is_action_pressed("throw_to_player4"):
				throw_to_player.emit(self.id, 3)
