extends TileMapLayer

var door_tiles = {}
var currently_hovered_door = null

func _ready():
	scan_for_doors()

func _input(event):
	if event is InputEventMouseMotion:
		handle_mouse_hover()

func scan_for_doors():
	var used_cells = get_used_cells()
	
	for cell_pos in used_cells:
		var tile_data = get_cell_tile_data(cell_pos)
		if tile_data and tile_data.get_custom_data("is_door"):
			door_tiles[cell_pos] = {
				"normal_coords": Vector2i(-1, -1),
				"hover_coords": Vector2i(1, 19),
				"source_id": get_cell_source_id(cell_pos)
			}

func handle_mouse_hover():
	var mouse_pos = get_global_mouse_position()
	var tile_pos = local_to_map(to_local(mouse_pos))
	
	if door_tiles.has(tile_pos):
		if currently_hovered_door != tile_pos:
			reset_hovered_door()
			currently_hovered_door = tile_pos
			set_door_hover_state(tile_pos, true)
	else:
		reset_hovered_door()

func set_door_hover_state(pos: Vector2i, is_hovering: bool):
	if not door_tiles.has(pos):
		return
	
	var door_data = door_tiles[pos]
	
	if is_hovering and door_data.has("hover_coords"):
		set_cell(pos, door_data.source_id, door_data.hover_coords)
	else:
		set_cell(pos, door_data.source_id, door_data.normal_coords)

func reset_hovered_door():
	if currently_hovered_door != null:
		set_door_hover_state(currently_hovered_door, false)
		currently_hovered_door = null
