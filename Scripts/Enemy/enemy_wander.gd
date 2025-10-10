extends EnemyState
@onready var player = $"../../../../Player"
var target: Vector2
@onready var sfx_chase: AudioStreamPlayer = $sfx_chase
@onready var sfx_wander_2: AudioStreamPlayer2D = $sfx_wander2
@onready var sfx_crowl: AudioStreamPlayer2D = $sfx_crowl

func enter() -> void:
	enemy.animated_sprite.play("walk1")
	sfx_wander_2.play()
	enemy.animated_sprite.speed_scale = 1.0
	set_random_target()

func set_random_target() -> void:
	sfx_chase.stop()
	var map_rid = enemy.nav_region.get_region_rid()
	target = NavigationServer2D.region_get_random_point(map_rid, 1, false)
	enemy.nav.target_position = target
	sfx_crowl.play()

func physics_update(delta: float) -> void:
	#var player = enemy.get_tree().get_first_node_in_group("player")
	if player:
		var distance = enemy.global_position.distance_to(player.global_position)
		#print(distance)
		if distance < 100 && enemy.can_see_player(player):
			get_parent().transition_to("chasestate")
			sfx_chase.play()
			return
	if enemy.nav.is_navigation_finished():
		set_random_target()
		return
	var next_pos = enemy.nav.get_next_path_position()
	var dir = (next_pos - enemy.global_position).normalized()
	enemy.velocity = dir * enemy.speed
	enemy.move_and_slide()

func exit() -> void:
	pass
