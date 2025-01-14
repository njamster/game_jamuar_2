extends Sprite2D

func _ready() -> void:
	EventBus.introduction_finished.connect(_on_introduciton_finished)


func _on_introduciton_finished() -> void:
	match get_parent().id:
		0:
			texture = preload("images/y_button.svg")
		1:
			texture = preload("images/a_button.svg")
		2:
			texture = preload("images/b_button.svg")
		3:
			texture = preload("images/x_button.svg")

	var tween := create_tween().set_loops()
	tween.tween_property(self, "position:y", -48, 0.35)
	tween.tween_property(self, "position:y", -40, 0.35)
