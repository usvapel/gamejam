class_name State extends Node

static var player: Player

func _ready():
	pass

func enter():
	pass
	
func exit():
	pass

func process(_delta: float) -> State:
	return null

func physics_process(_delt: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null
