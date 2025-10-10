extends Area2D

@onready var animation = $AnimatedSprite2D

func _ready() -> void:
	animation.play("closed")

func _process(delta: float) -> void:
	if global_var.collectibles == 0:
		animation.play("closed")
	if global_var.collectibles > 3:
		animation.play("open")
