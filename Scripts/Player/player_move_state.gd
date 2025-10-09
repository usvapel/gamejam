class_name PlayerMove extends State

@onready var sprite = %AnimatedSprite2D
@export var move_speed : float = 100.0
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const DASH_VELOCITY = -400.0

func enter():
	sprite.play("move")
	pass
	
func update(_delta:float):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	player.velocity = direction * move_speed
	if direction.x > 0:
		sprite.scale.x = 1
	elif direction.x < 0:
		sprite.scale.x = -1
	pass

func exit():
	pass
