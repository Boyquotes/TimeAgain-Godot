extends Control

onready var TransitionAim = $Transition/AnimatedSprite
onready var DestroySpriteTimer = $Transition/DestroySprite
onready var Transition = $Transition

func _ready():
	TransitionAim.playing = true


func _on_DestroySprite_timeout():
	Transition.queue_free()
