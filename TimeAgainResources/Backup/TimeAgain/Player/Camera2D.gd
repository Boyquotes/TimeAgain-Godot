extends Camera2D

var PlayerPos

onready var CameraSelf = $"."

var Enable = false
onready var Follow_Player_Timer = $Timer

var LevelCheckPoints

export var XLimitRight = int()
export var XLimitLeft = int()
export var ChangeScene = String()

var EndScene = false

#Scene Start
onready var SceneStart = $SceneStart
onready var StartTrans = $StartTrans

#Scene End
onready var SceneEnd = $SceneEnd
onready var ExitTrans = $ExitTrans

func _ready():
	SceneStart.playing = true

func _process(_delta):
	if Enable == true:
			PlayerPos = get_tree().get_root().get_node("LevelSpawn").get_node("Player").position
			position.x = PlayerPos.x
			if position.x < XLimitLeft:
				position.x = XLimitLeft
			if position.x > XLimitRight:
				position.x = XLimitRight

	if EndScene == true:
		CameraSelf.smoothing_enabled = false
		Enable = false
		SceneEnd.playing = true
		ExitTrans.start()
		EndScene = false

#Enable Camera to follow the player
func _on_Timer_timeout():
	Enable = true
	Follow_Player_Timer.queue_free()


#Start Scene Transition
func _on_StartTrans_timeout():
	SceneStart.queue_free()
	StartTrans.queue_free()

#Ending Transition Scene
func _on_ExitTrans_timeout():
	get_tree().change_scene(str("res://LevelsMainMenu/Levels/",ChangeScene,".tscn"))
