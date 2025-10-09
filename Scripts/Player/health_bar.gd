#extends Control
#
#@onready var health_texture = $TextureRect
#
##@export var health_100: Texture2D  # Full health bar image
##@export var health_75: Texture2D   # 75% health bar image
#@export var health_50: Texture2D   # 50% health bar image
##@export var health_25: Texture2D   # 25% health bar image
##@export var health_0: Texture2D    # Empty health bar image
#
#func _ready() -> void:
	##health_texture.texture = health_100
	## Keep at top-left corner
	#position = Vector2(10, 10)
#
#func update_health(current_health: int, max_health: int) -> void:
	#var health_percent = float(current_health) / float(max_health)
	#
	##if health_percent > 0.75:
		##health_texture.texture = health_100
	##elif health_percent > 0.5:
		##health_texture.texture = health_75
	#if health_percent > 0.25:
		#health_texture.texture = health_50
	##elif health_percent > 0:
		##health_texture.texture = health_25
	##else:
		##health_texture.texture = health_0
