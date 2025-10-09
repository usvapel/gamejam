class_name Enemy extends CharacterBody2D
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var nav : NavigationAgent2D = $NavigationAgent2D
@onready var nav_region: NavigationRegion2D = $"../../NavigationRegion2D"

@onready var state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var label = $Label

@export var speed = 30

func _ready() -> void:
	nav.path_desired_distance = 5
	nav.target_desired_distance = 10
	
func _process(delta: float) -> void:
	#if label:
		#label.text = "State: %s\nDone: %s\nReached: %s\nReachable: %s" % [
			#state_machine.current_state.name if state_machine.current_state else "None",
			#nav.is_navigation_finished(),
			#nav.is_target_reached(),
			#nav.is_target_reachable()
		#]
	pass

#var idle : bool = true
#var state = { "idle": false, "wandering": false }
#var target :Vector2
#
#func idle_state() -> void:
 #animated_sprite.play("idle")
#
#func set_wander_state() -> void:
 #var map_rid = nav_region.get_region_rid()
 #var p: Vector2 = NavigationServer2D.region_get_random_point(map_rid, 1, false)
 #target = p
 #nav.target_position = p
 #state["wandering"] = true
#
#func wander(delta : float) -> void:
 ##print("state: ", state["wandering"], "reached: ", nav.is_navigation_finished())
 ##if nav.is_navigation_finished():
  ##return
 ##print("x: ", target.x, "y: ", target.y)
 ##print("px: ", position.x, "py: ", position.y)
 ##if nav.is_navigation_finished():
  ##state["wandering"] = false
  ##set_wander_state()
  ##return
 #print("moving...")
 #var next_pos : Vector2 = nav.get_next_path_position()
 #var dir : Vector2 = Vector2(next_pos - global_position).normalized()
 #velocity = dir * speed
 #nav.set_velocity(velocity)
#
#func _ready() -> void:
 #nav.path_desired_distance = 100
 #nav.target_desired_distance = 30
#
#func _process(delta: float) -> void:
 #label.text = "done: %s\nReached: %s\nReachable: %s\n" % [
	#nav.is_navigation_finished(),
	#nav.is_target_reached(),
	#nav.is_target_reachable()
#]
 #pass
#
#func _physics_process(delta: float) -> void:
 #wander(delta)
 #move_and_slide()
#
#
##func _draw():
 ##draw_circle(nav.target_position, 10, Color.BLUE)
