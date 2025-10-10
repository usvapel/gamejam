extends Node2D

@onready var fader = $"fade"
@onready var anim = $"fade/AnimationPlayer"
@onready var timer = $"fade/Timer2"

@onready var sfx_theme: AudioStreamPlayer = $sfx_theme
@onready var sfx_press: AudioStreamPlayer = $sfx_press

@onready var start: Button = $Control/Start
@onready var quit: Button = $Control/Quit

var btn: String = ""

func _ready():
	sfx_theme.play()
	start.grab_focus() # Ensure keyboard/controller starts here

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		var focused = get_viewport().gui_get_focus_owner()
		if focused:
			sfx_press.play()
			focused.emit_signal("pressed")

func _on_button_pressed() -> void:
	btn = "start"
	fader.show()
	timer.start()
	anim.play("fade_in")

func _on_quit_pressed() -> void:
	btn = "quit"
	fader.show()
	timer.start()
	anim.play("fade_in")

func _on_fade_timer() -> void:
	if btn == "start":
		get_tree().change_scene_to_file("res://main.tscn")
	elif btn == "quit":
		get_tree().quit()
