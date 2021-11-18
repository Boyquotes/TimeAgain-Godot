extends Control

#Menu Switch
onready var MainMenu = $MainMenu
onready var OptionMenu = $OptionMenu
var ChangeMenu = 1

#Options
onready var VolumeSlider = $OptionMenu/VolumeSlider
onready var VolumePercent = $OptionMenu/VolumeSlider/VolumePercent

#Transition
onready var TransAnim = $AnimatedSprite
onready var Transition = $ScreenTransition

#Music
onready var MusicPlayer = $"/root/MusicControl"

func _ready():
	VolumeSlider.value = GlobalVariables.Volume
	VolumePercent.text = str(VolumeSlider.value)

func _process(_delta):
	#Menu Switch
	if ChangeMenu == 1:
		MainMenu.visible = true
		OptionMenu.visible = false
	elif ChangeMenu == 2:
		MainMenu.visible = false
		OptionMenu.visible = true
		
	#Options
	GlobalVariables.Volume = VolumeSlider.value
	VolumePercent.text = str(stepify(((VolumeSlider.value / 80) * 100),10))


func _on_OptionsButton_pressed():
	ChangeMenu = 2


func _on_BackButton_pressed():
	ChangeMenu = 1


func _on_PlayButton_pressed():
	TransAnim.playing = true
	Transition.start()

func _on_ScreenTransition_timeout():
	get_tree().change_scene("res://LevelsMainMenu/Tutorial/Tutorial.tscn")


func _on_VolumeSlider_value_changed(value):
	MusicPlayer.MusicVolume = value - 80
