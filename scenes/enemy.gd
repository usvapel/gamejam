class_name Enemy extends CharacterBody2D
@onready var animated_sprite : AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D
@onready var nav : NavigationAgent2D = $"../NavigationAgent2D"
@onready var tileMap: TileMap = $"../../TileMap"
@export var speed = 1
@onready var label = $"../Label"
var idle : bool = true
var state = { "idle": false, "wandering": false }
var target :Vector2
var walkable_cells: Array[Vector2i] = []

func _ready():
 nav.path_desired_distance = 100
 nav.target_desired_distance = 30
 nav.set_navigation_layer_value(0, 1)
 for cell in tileMap.get_used_cells(0):
  var tile_data = $TileMap.get_cell_tile_data(0, cell)
  if tile_data:
   for layer_index in range(tile_data.get_navigation_layers_count()):
	var hello = 1
	
func get_random_walkable_point() -> Vector2:
 if walkable_cells.size() == 0:
  return Vector2.ZERO
 var cell = walkable_cells[randi() % walkable_cells.size()]
 return tileMap.map_to_local(cell)

func idle_state() -> void:
 animated_sprite.play("idle")

func set_wander_state() -> void:
#
 var p: Vector2 = get_random_walkable_point()
 print("x", p.x, "y: ", p.y)
 target = p
 nav.target_position = p
 state["wandering"] = true

func wander(delta : float) -> void:
 #print("state: ", state["wandering"], "reached: ", nav.is_navigation_finished())
 #if nav.is_navigation_finished():
  #return
 #print("x: ", target.x, "y: ", target.y)
 #print("px: ", position.x, "py: ", position.y)
 if nav.is_navigation_finished():
  state["wandering"] = false
  set_wander_state()
  return
 print("moving...")
 var next_pos : Vector2 = nav.get_next_path_position()
 var dir : Vector2 = Vector2(next_pos - global_position).normalized()
 velocity = dir * speed
 nav.set_velocity(velocity)

#func _ready() -> void:
 #nav.path_desired_distance = 100
 #nav.target_desired_distance = 30
 #nav.set_navigation_layer_value(0, 1)

func _process(delta: float) -> void:
 label.text = "done: %s\nReached: %s\nReachable: %s\n" % [
	nav.is_navigation_finished(),
	nav.is_target_reached(),
	nav.is_target_reachable()
]
 pass

func _physics_process(delta: float) -> void:
 wander(delta)
 move_and_slide()


#func _draw():
 #draw_circle(nav.target_position, 10, Color.BLUE)
