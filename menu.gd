extends Node2D
@onready var fader = $"fade"
@onready var anim = $"fade/AnimationPlayer"
@onready var timer = $"fade/Timer2"
var btn = null

func _on_button_pressed() -> void:
	btn = "start"
	fader.show()
	timer.start()
	anim.play("fade_in")

func _on_quit_pressed() -> void:
	btn = "quit"

func _on_fade_timer() -> void:
	if btn == "start":
		get_tree().change_scene_to_file("res://main.tscn")
	if btn == "quit":
		get_tree().quit()
