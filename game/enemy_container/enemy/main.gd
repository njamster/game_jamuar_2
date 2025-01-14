extends Area2D

enum States {
	TUTORIAL,
	MOVING,
	DEAD
}

@export var current_state = States.MOVING:
	set(value):
		if current_state == value:
			return

		current_state = value

		$Trail.emitting = (current_state == States.MOVING)

var move_direction := Vector2.ZERO
var move_speed := 350


func _ready() -> void:
	$Trail.emitting = (current_state == States.MOVING)
	$DeathExplosion.emitting = false


func _physics_process(delta: float) -> void:
	if current_state == States.MOVING:
		position += move_direction * move_speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		body.kill()


func kill() -> void:
	$Sprite.hide()
	$Hitbox.set_deferred("disabled", true)
	set_deferred("current_state", States.DEAD)
	Global.enemies_killed += 1
	if current_state == States.TUTORIAL:
		EventBus.tutorial_finished.emit()
	$DeathExplosion.emitting = true
	SoundManager.play_sound_effect("smash")
	await $DeathExplosion.finished
	queue_free()


func _on_visibility_notifier_screen_exited() -> void:
	queue_free()
