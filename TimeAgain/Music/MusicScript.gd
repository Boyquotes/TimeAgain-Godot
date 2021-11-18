extends Node2D

var MusicFile = load("res://Music/Cruising_the_Night_Sky.ogg")
var MusicVolume = 0


func _ready():
	$MusicPlay.stream = MusicFile
	$MusicPlay.play()

func _process(_delta):
	$MusicPlay.volume_db = MusicVolume
	$MusicPlay.volume_db = clamp(MusicVolume,-80,0)
