extends EnemyState

var player: Node2D
var multiplier = 1

func enter() -> void:
	enemy.animated_sprite.play("walk")
	player = enemy.get_tree().get_first_node_in_group("player")
	
func can_see_player(player: Node2D) -> bool:
	var space_state = enemy.get_world_2d().direct_space_state
	
	var query = PhysicsRayQueryParameters2D.create(
		enemy.global_position,
		player.global_position
	)
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.exclude = [enemy]  # don't hit yourself

	var result = space_state.intersect_ray(query)

	if result.is_empty():
		# No obstacles in between → direct line of sight
		return true

	# Something blocked the ray
	return false

func physics_update(delta: float) -> void:
	if not player:
		get_parent().transition_to("idle")
		return
	
	var distance = enemy.global_position.distance_to(player.global_position)
	
	# Lost sight of player
	if distance > 150:  # Lost range is bigger than detection range
		get_parent().transition_to("wanderstate")
		return
	
	# Update navigation target to player position
	enemy.nav.target_position = player.global_position
	
	if not enemy.nav.is_navigation_finished():
		multiplier += 0.005
		var next_pos = enemy.nav.get_next_path_position()
		var dir = (next_pos - enemy.global_position).normalized()
		enemy.velocity = dir * enemy.speed * (2 * multiplier)  # Move faster when chasing
		enemy.move_and_slide()
