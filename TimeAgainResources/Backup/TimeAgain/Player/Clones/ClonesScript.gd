extends KinematicBody2D

onready var Colldown = $Timer
onready var TextTime = $TextTime #Disappear Timer
onready var Collider = $CollisionShape2D
onready var Animations = $AnimatedSprite #Appear/Disappear Effect Anim
onready var DisappearCooldown = $DisappearEffect #Disappear Timer
onready var Clone = $"."
onready var PlayerNode
var DisableClone = false

func _ready():
	Animations.playing = true
	PlayerNode = get_tree().get_root().get_node("LevelSpawn").get_node("Player")
	GlobalVariables.ClonesActive += 1

func _process(_delta):
	#Time Text
	TextTime.text = str(int(Colldown.time_left))
	
	#Player Distance
	var Distance = PlayerNode.position - position
	if (Distance.x > 60 || Distance.x < -60) || (Distance.y > 60 || Distance.y < -60) && DisableClone == false:
		Collider.disabled = false
	
	#Disable Node
	if DisableClone == true:
		Colldown.stop()
		TextTime.visible = false
		Collider.disabled = true

#Disappear Timer
func _on_Timer_timeout():
	GlobalVariables.ClonesActive -= 1
	DisableClone = true
	Animations.play("Disappear")
	DisappearCooldown.start()


#Disappear Effect
func _on_DisappearEffect_timeout():
	Clone.queue_free()
