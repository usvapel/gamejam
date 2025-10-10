extends Node2D

@onready var closed = $Closed
@onready var open = $Open

func _ready() -> void:
	closed.visible = true
	closed.collision_enabled = true
	open.visible = false

func _process(delta: float) -> void:
	if global_var.collectibles == 0:
		enable_door(closed)
		disable_door(open)
	if global_var.collectibles > 2:
		enable_door(open)
		disable_door(closed)

func disable_door(door: TileMapLayer):
	door.visible = false
	door.collision_enabled = false
	
func enable_door(door: TileMapLayer):
	door.visible = true
	door.collision_enabled = true
