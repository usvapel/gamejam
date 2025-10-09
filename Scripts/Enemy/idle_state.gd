class_name EnemyIdleState extends EnemyState

func enter() -> void:
	enemy.animated_sprite.play("idle")

func physics_update(delta: float) -> void:
	var player = enemy.get_tree().get_first_node_in_group("player")
	if player:
		var distance = enemy.global_position.distance_to(player.global_position)
		if distance < 200:
			get_parent().transition_to("chasestate")
			return
	
	if randf() < 0.9:
		get_parent().transition_to("wanderstate")
