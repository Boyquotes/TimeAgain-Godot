extends Node2D

var PlayerPos
export var TextAppearDistance = int()

onready var LabelText = $Text
var TextAppearBool = false

func _ready():
	LabelText.percent_visible = 0

func _process(delta):
	if TextAppearBool == false:
		PlayerPos = get_tree().get_root().get_node("LevelSpawn").get_node("Player").position
		var Difference = PlayerPos.x - position.x
		if Difference > TextAppearDistance:
			TextAppearBool = true
	else:
		LabelText.percent_visible += 1 * delta
