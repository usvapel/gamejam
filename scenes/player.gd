class_name Player extends CharacterBody2D

@export var move_speed : float = 100.0
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const DASH_VELOCITY = -400.0
var state : String = "idle"

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _process( delta: float ):

	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = direction * move_speed
	if velocity.length() == 0:
		animated_sprite.play("idle")
	else:
		if direction.x > 0:
			animated_sprite.scale.x = 1
		elif direction.x < 0:
			animated_sprite.scale.x = -1
		animated_sprite.play("move")
	pass
	

func _physics_process(delta: float) -> void:
	move_and_slide()
