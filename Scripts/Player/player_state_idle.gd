class_name State_Idle extends State

@onready var move = $"../Move"

func enter():
	player.update_animation("idle")
	pass
	
func exit():
	pass

func process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return move
	player.velocity = Vector2.ZERO
	return null

func physics_process(_delt: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null
