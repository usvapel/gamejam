class_name StateMachine extends Node

var states : Dictionary = {}
var prev_state : State
var current_state : State

func _ready():
	#process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process(delta):
	change_state(current_state.process(delta))

func _physics_process(delta):
	change_state(current_state.physics_process(delta))

func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))


func initialize(player: Player):
	await owner.ready
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.player = player
	change_state(states.get("idle"))
	#process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state : State):
	if new_state == null || new_state == current_state:
		return
	if current_state:
		current_state.exit()
	prev_state = current_state
	current_state = new_state
	current_state.enter()
	pass

func force_change_state(newState: String):
	var new_state = states.get(newState.to_lower())
	if (!new_state):
		print(newState + " doesn't exist in dictionary")
		return
	if current_state == new_state:
		print("State is same")
		return
	if current_state:
		var exit_callable = Callable(current_state, "Exit")
		exit_callable.call_deferred()
	new_state.enter()
	current_state = new_state
	return
