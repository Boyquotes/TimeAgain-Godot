extends TextureRect

onready var Cooldown = $Timer
onready var TitleAnim = $TitleAnim

func _on_Timer_timeout():
	TitleAnim.playing = true
