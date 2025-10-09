extends TileMapLayer

var door_tiles = {}
var player_node = null

enum DoorState { CLOSED, OPEN }
var door_states = {}

func _ready():
	scan_for_doors()
	find_player()

func find_player():
	player_node = get_node("../Player")
	if player_node != null:
		return

func scan_for_doors():
	var used_cells = get_used_cells()
	
	for cell_pos in used_cells:
		var atlas_coords = get_cell_atlas_coords(cell_pos)
		var source_id = get_cell_source_id(cell_pos)
	
	for cell_pos in used_cells:
		var atlas_coords = get_cell_atlas_coords(cell_pos)
		var source_id = get_cell_source_id(cell_pos)
		
		if atlas_coords == Vector2i(0, 17):
		#var tile_data = get_cell_tile_data(cell_pos)
		#if tile_data and tile_data.get_custom_data("is_door"):
			door_tiles[cell_pos] = {
				"closed_coords": Vector2i(0, 17),
				"open_coords": Vector2i(11, 21),
				"source_id": source_id
			}
			door_states[cell_pos] = DoorState.CLOSED
	
func _input(event):
	if Input.is_action_just_pressed("interact"):
		handle_door_interaction()

func handle_door_interaction():
	if player_node == null:
		return
	
	var player_pos = player_node.global_position
	var player_tile_pos = local_to_map(to_local(player_pos))
	
	var adjacent_tiles = [
		player_tile_pos + Vector2i(0, -1),  # Up
		player_tile_pos,
	]
	
	for tile_pos in adjacent_tiles:
		if door_tiles.has(tile_pos):
			toggle_door(tile_pos)
			break
	
func toggle_door(pos: Vector2i):
	if not door_tiles.has(pos):
		return
	
	var door_data = door_tiles[pos]
	var current_state = door_states[pos]
	
	if current_state == DoorState.CLOSED:
		door_states[pos] = DoorState.OPEN
		set_cell(pos, door_data.source_id, door_data.open_coords)
	else:
		door_states[pos] = DoorState.CLOSED
		set_cell(pos, door_data.source_id, door_data.closed_coords)
