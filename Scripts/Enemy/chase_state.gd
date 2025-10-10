extends EnemyState
@onready var player = $"../../../../Player"
@onready var sfx_explosion: AudioStreamPlayer = $"../ExplosionState/sfx_explosion"



var multiplier = 1
var has_exploded = false  

func enter() -> void:
	enemy.animated_sprite.play("explosion")
	
	has_exploded = false
	multiplier = 1

func physics_update(delta: float) -> void:
	if not player:
		get_parent().transition_to("idle")
		return

	var distance = enemy.global_position.distance_to(player.global_position)
	if distance <= 5 and not has_exploded:
		#get_parent().transition_to("explosionstate")
		sfx_explosion.play()
		explode()
		return
	if distance > 150 or not enemy.can_see_player(player):
		get_parent().transition_to("wanderstate")
		return
	
	enemy.nav.target_position = player.global_position
	
	if not enemy.nav.is_navigation_finished():
		multiplier = min(multiplier + 0.005, 3.0)
		var next_pos = enemy.nav.get_next_path_position()
		var dir = (next_pos - enemy.global_position).normalized()
		enemy.velocity = dir * enemy.speed * (2 * multiplier)  # Move faster when chasing
		enemy.animated_sprite.speed_scale = min(1.0 + multiplier, 15)
		enemy.move_and_slide()
		
func explode() -> void:
	#print("exploding")
	has_exploded = true
	enemy.velocity = Vector2.ZERO
	enemy.animated_sprite.play("explosion")
	enemy.animated_sprite.speed_scale = 1.0
	
	if player and player.has_method("take_damage"):
		player.take_damage(50)
	
	await get_tree().create_timer(0.5).timeout 
	enemy.queue_free()
