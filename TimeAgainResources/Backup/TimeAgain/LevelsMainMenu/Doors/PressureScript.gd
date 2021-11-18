extends KinematicBody2D

var Activated = false
 
onready var PressureArea = $Area2D
onready var PresssureAnim = $AnimationPlayer


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		PresssureAnim.play("Active")
		Activated = true
		PressureArea.queue_free()
