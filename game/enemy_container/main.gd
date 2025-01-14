extends Path2D


func _ready() -> void:
	EventBus.tutorial_finished.connect(_on_tutorial_finished)


func spawn() -> void:
	# pick a random spawn position along the path
	$SpawnPosition.progress_ratio = randf_range(0, 1)

	var enemy := preload("enemy/main.tscn").instantiate()
	enemy.position = $SpawnPosition.position
	enemy.rotation = $SpawnPosition.rotation + randf_range(-PI/4, PI/4)
	enemy.move_direction = Vector2.DOWN.rotated(enemy.rotation)
	add_child(enemy)


func _on_tutorial_finished() -> void:
	$SpawnTimer.start()
