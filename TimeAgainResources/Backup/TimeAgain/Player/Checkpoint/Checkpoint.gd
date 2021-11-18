extends Node2D

onready var Checkpoint = $"." #Check Node
onready var CheckRay2D = $Ray2D #Check Ray2D
onready var CheckText = $CheckText #Check Text
var TextAnim = false
var RayActive = true
var StartPos

func _ready():
	StartPos = get_tree().get_root().get_node("LevelSpawn").get_node("StartPosition")

func _process(delta):
	if RayActive == true:
		if CheckRay2D.is_colliding():
			var Object_Colling_With = CheckRay2D.get_collider()
			if Object_Colling_With.is_in_group("Player") == true:
				StartPos.set_position(Vector2(Checkpoint.position.x,Checkpoint.position.y + 50))
				TextAnim = true
				RayActive = false
				CheckRay2D.queue_free()
	if TextAnim == true:
		CheckText.percent_visible += 1 * delta
	
