class_name PlayerLight extends PointLight2D

func _process(delta: float) -> void:
		look_at(get_global_mouse_position())
pass
