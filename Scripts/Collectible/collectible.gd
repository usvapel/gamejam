extends Area2D



func _ready() -> void:
	var animation = $AnimatedSprite2D
	animation.play("default")

func _on_body_entered(body: Node2D) -> void:
	if body.name.to_lower() == "player":
		body.collectibles += 1
		print(body.collectibles)			
		self.queue_free()
	pass
