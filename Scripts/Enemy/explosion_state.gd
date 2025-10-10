extends EnemyState

@onready var player: Node2D = $"../../../../Player"
var explosion_timer: float = 0.0
const EXPLOSION_DELAY = 0.5  # Half second before exploding

func enter() -> void:
	enemy.animated_sprite.play("explosion")  # or whatever animation you have
	enemy.animated_sprite.speed_scale = 1.0
	explosion_timer = 0.0
	enemy.velocity = Vector2.ZERO  # Stop moving

func physics_update(delta: float) -> void:
	explosion_timer += delta
	print("Exploding")
	if explosion_timer >= EXPLOSION_DELAY:
		explode()

func explode() -> void:
	if player and player.has_method("take_damage"):
		var distance = enemy.global_position.distance_to(player.global_position)
		if distance <= 50:  # Explosion radius
			player.take_damage(50)  # Half of 100 health
	
	# Remove the enemy
	enemy.queue_free()
