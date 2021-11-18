extends Control

onready var PlayerAnim = $AnimationPlayer
onready var ShowHideText = $Text

func _ready():
	ShowHideText.visible = false
	PlayerAnim.play("ClockAnim")
	PlayerAnim.playback_speed = 0.2

func _on_ButtonTemplate_mouse_entered():
	ShowHideText.visible = true
	PlayerAnim.playback_speed = 1.0


func _on_ButtonTemplate_mouse_exited():
	ShowHideText.visible = false
	PlayerAnim.playback_speed = 0.2
