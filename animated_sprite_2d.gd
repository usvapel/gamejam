extends AnimatedSprite2D
@onready var health_bar: AnimatedSprite2D = $"."

func _ready():
	health_bar.position = Vector2i(430, 20)
	health_bar.play("100")
