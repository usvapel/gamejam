extends Area2D

extends Sprite  # this is the node type you want the script to be attached to

@export var normal_texture: Texture2D # you need to set this value in the inspector
@export var hover_texture: Texture2D # along with this one too

func _ready():
	$Area2D.connect("mouse_entered", mouse_entered)
	$Area2D.connect("mouse_exited", mouse_exited)

func mouse_entered():
   texture = hover_texture

func mouse_exited():
	texture = normal_texture
