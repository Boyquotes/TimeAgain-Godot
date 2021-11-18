extends Node2D

onready var StartPosition = $StartPosition

var ViewNext = 0

func _ready():
	var PlayerScene = load("res://Player/Player.tscn")
	var ActivatePlayer = PlayerScene.instance()
	ActivatePlayer.set_position(StartPosition.global_position)
	add_child(ActivatePlayer)
