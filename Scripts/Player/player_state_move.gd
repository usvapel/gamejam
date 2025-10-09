class_name State_Move extends State

@export var move_speed : float = 100.0
@onready var idle : State = $"../Idle"

func enter():
	player.update_animation("move")
	pass
	
func exit():
	pass
	

func process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	player.velocity = player.direction * move_speed
	if player.set_direction():
		player.update_animation("move")
	return null

func physics_process(_delt: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null
