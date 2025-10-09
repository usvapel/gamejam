extends TileMapLayer

var door_tiles = {}
var player_node = null

# Door states
enum DoorState { CLOSED, OPEN }
var door_states = {}

func _ready():
	scan_for_doors()
	find_player()

func find_player():
	print("=== LOOKING FOR PLAYER ===")
	player_node = get_node("../Player")
	if player_node != null:
		print("Found player at ../Player")
		return
	if player_node == null:
		# Try alternative paths
		player_node = get_tree().get_first_node_in_group("player")
		
	if player_node == null:
		print("Warning: Player node not found. Adjust the path in find_player()")

func scan_for_doors():
	print("=== SCANNING ALL TILES ===")
	var used_cells = get_used_cells()
	print("Total tiles in tilemap: ", used_cells.size())
	
	# Print ALL tiles to see what's actually there
	for cell_pos in used_cells:
		var atlas_coords = get_cell_atlas_coords(cell_pos)
		var source_id = get_cell_source_id(cell_pos)
		print("Tile at scene pos ", cell_pos, " -> Atlas coords: ", atlas_coords, " Source: ", source_id)
	
	print("=== NOW LOOKING FOR DOORS ===")
	
	for cell_pos in used_cells:
		var atlas_coords = get_cell_atlas_coords(cell_pos)
		var source_id = get_cell_source_id(cell_pos)
		
		# Check if this is your door sprite
		if atlas_coords == Vector2i(0, 17):  # Your door coordinates
			print("FOUND DOOR at scene position: ", cell_pos)
			door_tiles[cell_pos] = {
				"closed_coords": Vector2i(0, 17),  # Closed door
				"open_coords": Vector2i(1, 19),    # Open door sprite coordinates
				"source_id": source_id
			}
			door_states[cell_pos] = DoorState.CLOSED
	
	print("Total doors found: ", door_tiles.size())
	print("Looking for atlas coordinates: Vector2i(5, 21)")

func _input(event):
	if Input.is_action_just_pressed("interact"):
		print("INTERACT key pressed!")  # Added debug
		handle_door_interaction()

func handle_door_interaction():
	print("=== DOOR INTERACTION ===")  # Added debug
	
	if player_node == null:
		print("ERROR: Player node is null!")  # Added debug
		return
	
	var player_pos = player_node.global_position
	var player_tile_pos = local_to_map(to_local(player_pos))
	
	print("Player world position: ", player_pos)  # Added debug
	print("Player tile position: ", player_tile_pos)  # Added debug
	
	# Check adjacent tiles for doors
	var adjacent_tiles = [
		player_tile_pos + Vector2i(0, -1),  # Up
		player_tile_pos + Vector2i(0, 1),   # Down
		player_tile_pos + Vector2i(-1, 0),  # Left
		player_tile_pos + Vector2i(1, 0),   # Right
	]
	
	print("Checking adjacent tiles: ", adjacent_tiles)  # Added debug
	
	for tile_pos in adjacent_tiles:
		print("Checking tile: ", tile_pos, " - Has door: ", door_tiles.has(tile_pos))  # Added debug
		if door_tiles.has(tile_pos):
			print("INTERACTING with door at: ", tile_pos)  # Added debug
			toggle_door(tile_pos)
			break  # Only interact with one door at a time
	
	print("No door interaction occurred")  # Added debug

func toggle_door(pos: Vector2i):
	print("=== TOGGLING DOOR at ", pos, " ===")  # Added debug
	
	if not door_tiles.has(pos):
		print("ERROR: No door data found!")  # Added debug
		return
	
	var door_data = door_tiles[pos]
	var current_state = door_states[pos]
	
	print("Current door state: ", current_state)  # Added debug
	
	if current_state == DoorState.CLOSED:
		# Open the door
		door_states[pos] = DoorState.OPEN
		set_cell(pos, door_data.source_id, door_data.open_coords)
		print("Door OPENED! Changed to coords: ", door_data.open_coords)  # Added debug
	else:
		# Close the door
		door_states[pos] = DoorState.CLOSED
		set_cell(pos, door_data.source_id, door_data.closed_coords)
		print("Door CLOSED! Changed to coords: ", door_data.closed_coords)  # Added debug
