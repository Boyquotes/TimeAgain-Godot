extends KinematicBody2D

export var PressureName = String()
onready var DoorAnim = $AnimationPlayer
onready var PressureChosen = get_node("..").get_node(PressureName)

var StopLoop = false

func _process(delta):
	if PressureChosen.Activated == true && StopLoop == false:
		DoorAnim.play("Active")
		StopLoop = true
