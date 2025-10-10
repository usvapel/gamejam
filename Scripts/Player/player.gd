class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const DASH_VELOCITY = -400.0
var max_health = 100 
var health = 100

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : StateMachine = %StateMachine
#@onready var health_bar_ui = $"../../CanvasLayer/HealthBar"
@onready var health_bar: AnimatedSprite2D = $"../../CanvasLayer/Health/AnimatedSprite2D"

# sounds
@onready var sfx_walk: AudioStreamPlayer = $sfx_walk

func _ready():
	#if health_bar_ui:
		#health_bar_ui.update_health(health, max_health)
	state_machine.initialize(self)

func _process( _delta: float ):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	pass
	

func _physics_process(_delta: float) -> void:
	move_and_slide()
	# play sound
	if direction.length() > 0:
		if not sfx_walk.playing:
			sfx_walk.play()
	else:
		sfx_walk.stop()

func set_direction() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	if new_dir == cardinal_direction:
		return false
	cardinal_direction = new_dir
	animated_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
func update_animation (state : String):
	animated_sprite.play(state)
	pass
	
func take_damage(amount: int) -> void:
	health -= amount
	print("Player took ", amount, " damage! Health: ", health)
	health_bar.play(str(health))
	if health <= 0:
		die()

func die() -> void:
	print("Player died!")
	get_tree().quit()
