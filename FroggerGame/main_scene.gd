
extends Node2D

var isButtonPressed = false
var bgWidth = 540
var bgHeigh = 711
var frogWidth = 71
var frogHeigh = 71
var jump = 400

func _ready():
	set_process(true)

func _process(delta):
	var frog = get_node("frog")
	var frogPos = frog.get_pos()
	if Input.is_action_pressed("ui_up"):
		if isButtonPressed == false && frogPos.y > frogHeigh / 2:
			frogPos.y = frogPos.y - jump * delta
			print("UP!")
			isButtonPressed = true
			frog.set_rot(PI*2)
			
	else:
		isButtonPressed = false
	if Input.is_action_pressed("ui_left"):
		if isButtonPressed == false && frogPos.x > frogWidth/2:
			frogPos.x = frogPos.x - jump * delta
			
			print("LEFT!")
			isButtonPressed = true
			frog.set_rot(PI/2)
	else:
		isButtonPressed = false
	
	if Input.is_action_pressed("ui_right"):
		if isButtonPressed == false && frogPos.x < bgWidth:
			frogPos.x = frogPos.x + jump * delta
			print("RIGHT!")
			isButtonPressed = true
			frog.set_rot(PI*1.5)
	else:
		isButtonPressed = false
	
	if Input.is_action_pressed("ui_down"):
		print (frogPos.y);
		if isButtonPressed == false && frogPos.y < (bgHeigh - frogHeigh / 2):
			frogPos.y = frogPos.y + jump * delta
			print("DOWN!")
			isButtonPressed = true
			frog.set_rot(PI*3)
	else:
		isButtonPressed = false
	
	
	get_node("frog").set_pos(frogPos)
