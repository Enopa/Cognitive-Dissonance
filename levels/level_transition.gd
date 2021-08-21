extends Node2D


onready var anim_player = $AnimationPlayer

func _ready():
	visible = true
	fade_out()

func fade_in():
	anim_player.play("FadeIn")

func fade_out():
	anim_player.play("FadeOut")
