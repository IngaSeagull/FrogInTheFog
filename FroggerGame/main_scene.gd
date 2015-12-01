
extends Node2D

var isButtonPressed = false
var bgWidth = 540
var bgHeigh = 711
var frogWidth = 71
var frogHeigh = 71
var jump = 400
var car = preload ("res://cars.xml")
var carCount = 0;
var carArray = []
var timeSinceLastCar = 0
var wood = preload ("res://wood.xml")
var woodCount = 0;
var woodArray = []
var timeSinceLastWood = 0

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
	
	var carId = 0
	for car in carArray:
		var carPos = get_node(car).get_pos()
		carPos.x = carPos.x - 250 * delta
		get_node(car).set_pos(carPos)
		if carPos.x > 1282:
			get_node(car).queue_free()
			carArray.remove(carId)
		carId = carId + 1
	
	timeSinceLastCar = timeSinceLastCar + delta
	if (timeSinceLastCar > 5):
		newCar()
		timeSinceLastCar = 0
		
	var woodId = 0
	for wood in woodArray:
		var woodPos = get_node(wood).get_pos()
		woodPos.x = woodPos.x - 250 * delta
		get_node(wood).set_pos(woodPos)
		if woodPos.x > 1282:
			get_node(wood).queue_free()
			woodArray.remove(woodId)
		woodId = woodId + 1
		
	timeSinceLastWood = timeSinceLastWood + delta
	if (timeSinceLastWood > 5):
		newWood()
		timeSinceLastWood = 0

func newCar():
	carCount = carCount + 1
	print("car")
	var car_instance = car.instance()
	car_instance.set_name("car" + str(carCount))
	add_child(car_instance)
	var carPos = get_node("car"+ str(carCount)).get_pos()
	carPos.y = 500
	carPos.x = 1282
	get_node("car"+ str(carCount)).set_pos(carPos)
	carArray.push_back("car"+ str(carCount))
	print(carArray)
	
func newWood():
	woodCount = woodCount + 1
	print("wood")
	var wood_instance = wood.instance()
	wood_instance.set_name("wood" + str(woodCount))
	add_child(wood_instance)
	var woodPos = get_node("wood"+ str(woodCount)).get_pos()
	woodPos.y = 200
	woodPos.x = 1282
	get_node("wood"+ str(woodCount)).set_pos(woodPos)
	woodArray.push_back("wood"+ str(woodCount))
	print(woodArray)