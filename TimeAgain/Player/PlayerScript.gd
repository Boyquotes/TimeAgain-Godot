extends KinematicBody2D

#Ground Rays
onready var GroundDetectMiddle = $GroundDetectNode/GroundDetectMiddle #Middle RayCast2D
onready var GroundDetectLeft = $GroundDetectNode/GroundDetectLeft #Left RayCast2D
onready var GroundDetectRight = $GroundDetectNode/GroundDetectRight #Right RayCast2D

#Sides Rays
onready var RightSideRay = $SidesDetect/Right
onready var LeftSideRay = $SidesDetect/Left
var RighSideColliding = false
var LeftSideColliding = false

onready var PlayerComponent = $"."
onready var PlayerAnim = $AnimatedSprite

var ClonesLimit

var IsGrounded = true #Detect if the player is hitting the ground
var Velocity = Vector2()

var RespawnPosition

func _ready():
	ClonesLimit = GlobalVariables.ClonesLimit
	RespawnPosition = get_tree().get_root().get_node("LevelSpawn").get_node("StartPosition")

# warning-ignore:unused_argument
func _process(delta):
	#Respawn
	if Input.is_action_just_pressed("Respawn"):
		position = RespawnPosition.get_position()
		Velocity = Vector2.ZERO
		
	#Clones
	if Input.is_action_just_pressed("ui_clone"):
		if GlobalVariables.ClonesActive < ClonesLimit:
			var CloneScene = load("res://Player/Clones/Clones.tscn")
			var ActivateClone = CloneScene.instance()
			get_tree().get_root().get_node("LevelSpawn").add_child(ActivateClone)
			ActivateClone.set_position(position)
		
func _physics_process(delta):
	#Horizontal Movement
	if Input.is_action_pressed("ui_left"):
		if Velocity.x < 0:
			Velocity.x -= 500 * delta
			if LeftSideColliding == false:
				PlayerAnim.play("Walk")
			else:
				PlayerAnim.play("Idle")
		else:
			Velocity.x -= 1000 * delta
			if LeftSideColliding == false:
				PlayerAnim.play("Walk")
			else:
				PlayerAnim.play("Idle")
	if Input.is_action_pressed("ui_right"):
		if Velocity.x > 0:
			Velocity.x += 500 * delta
			if RighSideColliding == false:
				PlayerAnim.play("Walk")
			else:
				PlayerAnim.play("Idle")
		else:
			Velocity.x += 1000 * delta
			if RighSideColliding == false:
				PlayerAnim.play("Walk")
			else:
				PlayerAnim.play("Idle")
	
	#Limit X Velocity
	Velocity.x = clamp(Velocity.x,-350,350)
	
	#Return X To normal if nothing is pressed
	if !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		if Velocity.x > 5.5:
			Velocity.x -= 800 * delta
		elif Velocity.x < -5.5:
			Velocity.x += 800 * delta
		else:
			Velocity.x = 0
			PlayerAnim.play("Idle")
	
	#Side RayCast
	if RightSideRay.is_colliding():
		var Object_Colliding_RightSide = RightSideRay.get_collider()
		if Object_Colliding_RightSide.is_in_group("Ground") == true:
			if Velocity.x > 0:
				Velocity.x = 0
				RighSideColliding = true
	else:
		RighSideColliding =	false
	if LeftSideRay.is_colliding():
		var Object_Colliding_LeftSide = LeftSideRay.get_collider()
		if Object_Colliding_LeftSide.is_in_group("Ground") == true:
			if Velocity.x < 0:
				Velocity.x = 0
				LeftSideColliding = true
	else:
		LeftSideColliding = false
	
	#Ground RayCast
	if GroundDetectMiddle.is_colliding():
		var Object_Colliding_Middle = GroundDetectMiddle.get_collider()
		if Object_Colliding_Middle.is_in_group("Ground") == true:
			IsGrounded = true
		elif Object_Colliding_Middle.is_in_group("Death") == true:
			position = RespawnPosition.get_position()
			Velocity = Vector2.ZERO
	elif GroundDetectLeft.is_colliding():
		var Object_Colliding_Left = GroundDetectLeft.get_collider()
		if Object_Colliding_Left.is_in_group("Ground") == true:
			IsGrounded = true
	elif GroundDetectRight.is_colliding():
		var Object_Colliding_Right = GroundDetectRight.get_collider()
		if Object_Colliding_Right.is_in_group("Ground") == true:
			IsGrounded = true
	else:
		IsGrounded = false
	
	#Y Velocity To Normal
	if IsGrounded == false:
		if Velocity.y < 0:
			Velocity.y += 600 * delta
		else:
			Velocity.y += 700 * delta
	else:
		if Input.is_action_just_pressed("Jump"):
			Velocity.y = -300
		if Velocity.y > 0:
			Velocity.y = 0
	Velocity.y = clamp(Velocity.y,-300,600) #Limit Y velocity
	
	#Apply Velocity
	move_and_slide(Velocity)
