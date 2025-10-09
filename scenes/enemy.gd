class_name Enemy extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D

	
var idle : bool = true
var states = { idle: idle_state }
func idle_state() -> void:
 animated_sprite.play("idle")

func _process(delta: float) -> void:
 pass

func _physics_process(delta: float) -> void:
 move_and_slide()
