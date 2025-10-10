extends Area2D

func _ready() -> void:
	var animation = $AnimatedSprite2D
	animation.play("closed")
