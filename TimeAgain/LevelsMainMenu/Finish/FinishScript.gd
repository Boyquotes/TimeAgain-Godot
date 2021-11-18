extends Node2D

onready var AnimLoop = $AnimationPlayer
onready var CameraEnd

func _ready():
	CameraEnd = get_tree().get_root().get_node("LevelSpawn").get_node("Camera2D")

func _process(_delta):
	if AnimLoop.is_playing() == false:
		AnimLoop.play("Idle")


func _on_AreaCollide_body_entered(body):
	if body.is_in_group("Player"):
		CameraEnd.EndScene = true
