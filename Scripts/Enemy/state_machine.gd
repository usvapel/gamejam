class_name EnemyStateMachine extends Node

@export var initial_state_path: NodePath

var current_state: EnemyState
var states: Dictionary = {}

func _ready() -> void:
	await owner.ready
	
	for child in get_children():
		if child is EnemyState:
			states[child.name.to_lower()] = child
			var parent_node = get_parent()
			print("Assigning parent to state: ", parent_node.name)
			child.enemy = parent_node as Enemy
			if child.enemy == null:
				print("ERROR: Could not cast parent to Enemy!")
				
	if not initial_state_path.is_empty():
		current_state = get_node(initial_state_path)
		current_state.enter()
		
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
		
func transition_to(state_name: String) -> void:
	var new_state = states.get(state_name.to_lower())
	if new_state == null or new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
