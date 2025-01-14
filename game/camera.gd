extends Camera2D

var max_offset := Vector2(15, 15)
var trauma := 0.0
var decay := 0.8


func _ready() -> void:
	set_process(false)

	EventBus.player_died.connect(shake_screen)


func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0.0)
		offset.x = max_offset.x * trauma * randf_range(-1, 1)
		offset.y = max_offset.y * trauma * randf_range(-1, 1)
	else:
		set_process(false)


func shake_screen():
	trauma = 1.0
	set_process(true)
