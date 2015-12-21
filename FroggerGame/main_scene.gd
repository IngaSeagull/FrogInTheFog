
extends Node2D

var isButtonPressed = false
var bgWidth = 750
var bgHeigh = 650
var frogWidth = 50
var frogHeight = 50
var jump = 400
var car = preload ("res://cars.xml")
var carWidth = 100
var carHeight = 50
var carCount = 0
var carArray = []
var timeSinceLastCar = 0
var grayCar = preload ("res://gray_car.xml")
var grayCarCount = 0;
var grayCarArray = []
var blueCar2 = preload ("res://blue_car2.xml")
var blueCar2Count = 0;
var blueCar2Array = []
var timeSinceLastBlueCar2 = 0
var redCar2 = preload ("res://red_car2.xml")
var redCar2Count = 0;
var redCar2Array = []
var wood = preload ("res://wood.xml")
var woodCount = 0;
var woodArray = []
var timeSinceLastWood = 0
var gameRunning = true

var canJump = true

func _ready():
	set_process(true)

func _process(delta):
	if gameRunning == true:
		game(delta)

func game(delta):
	var frog = get_node("frog")
	var frogPos = frog.get_pos()
	#if (jumpCounter >= jumpDelay):
	#	jumpCounter = 0
	#	canJump = false
	if Input.is_action_pressed("ui_up"):
		if isButtonPressed == false && frogPos.y > frogHeight / 2:
			if (canJump == true):
				canJump = false
				get_node("jump-delay").start()
				frogPos.y = frogPos.y - frogHeight
				print("UP!")
				isButtonPressed = true
				frog.set_rot(PI*2)
			
	else:
		isButtonPressed = false
	if Input.is_action_pressed("ui_left"):
		if isButtonPressed == false && frogPos.x > frogWidth/2:
			if (canJump == true):
				canJump = false
				get_node("jump-delay").start()
				frogPos.x = frogPos.x - frogWidth
			
				print("LEFT!")
				isButtonPressed = true
				frog.set_rot(PI/2)
	else:
		isButtonPressed = false
	
	if Input.is_action_pressed("ui_right"):
		if isButtonPressed == false && frogPos.x < bgWidth:
			if (canJump == true):
				canJump = false
				get_node("jump-delay").start()
				frogPos.x = frogPos.x + frogWidth
				print("RIGHT!")
				isButtonPressed = true
				frog.set_rot(PI*1.5)
	else:
		isButtonPressed = false
	
	if Input.is_action_pressed("ui_down"):
		print (frogPos.y);
		if isButtonPressed == false && frogPos.y < (bgHeigh - frogHeight / 2):
			if (canJump == true):
				canJump = false
				get_node("jump-delay").start()
				frogPos.y = frogPos.y + frogHeight
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
		if carPos.x > bgWidth:
			get_node(car).queue_free()
			carArray.remove(carId)
		carId = carId + 1
	
	timeSinceLastCar = timeSinceLastCar + delta
	if (timeSinceLastCar > 2):
		newCar()
		timeSinceLastCar = 0
		
	var grayCarId = 0
	for grayCar in grayCarArray:
		var grayCarPos = get_node(grayCar).get_pos()
		grayCarPos.x = grayCarPos.x - 250 * delta
		get_node(grayCar).set_pos(grayCarPos)
		if grayCarPos.x > bgWidth:
			get_node(grayCar).grayCarqueue_free()
			grayCarArray.remove(grayCarId)
		grayCarId = grayCarId + 1
	
	timeSinceLastCar = timeSinceLastCar + delta
	if (timeSinceLastCar > 2):
		newGrayCar()
		timeSinceLastCar = 0
		
	var blueCar2Id = 0
	for blueCar2 in blueCar2Array:
		var blueCar2Pos = get_node(blueCar2).get_pos()
		blueCar2Pos.x = blueCar2Pos.x + 250 * delta
		get_node(blueCar2).set_pos(blueCar2Pos)
		if blueCar2Pos.x < 0:
			#get_node(blueCar2).blueCar2queue_free()
			blueCar2Array.remove(blueCar2Id)
		blueCar2Id = blueCar2Id + 1
	
	timeSinceLastBlueCar2 = timeSinceLastBlueCar2 + delta
	if (timeSinceLastBlueCar2 > 2):
		newBlueCar2()
		timeSinceLastBlueCar2 = 0
		
	var redCar2Id = 0
	for redCar2 in redCar2Array:
		var redCar2Pos = get_node(redCar2).get_pos()
		redCar2Pos.x = redCar2Pos.x + 250 * delta
		get_node(redCar2).set_pos(redCar2Pos)
		if redCar2Pos.x < 0:
			#get_node(blueCar2).redCar2queue_free()
			redCar2Array.remove(redCar2Id)
		redCar2Id = redCar2Id + 1
	
	timeSinceLastBlueCar2 = timeSinceLastBlueCar2 + delta
	if (timeSinceLastBlueCar2 > 2):
		newRedCar2()
		timeSinceLastBlueCar2 = 0
		
	var woodId = 0
	for wood in woodArray:
		var woodPos = get_node(wood).get_pos()
		woodPos.x = woodPos.x - 100 * delta
		get_node(wood).set_pos(woodPos)
		if woodPos.x > bgWidth:
			get_node(wood).queue_free()
			woodArray.remove(woodId)
		woodId = woodId + 1
		
	timeSinceLastWood = timeSinceLastWood + delta
	if (timeSinceLastWood > 3):
		newWood()
		timeSinceLastWood = 0
		
	
	var grayCarId = 0
	for grayCar in grayCarArray:
		var grayCarPos = get_node(grayCar).get_pos()
		var frogPos = get_node("frog").get_pos()
		if (((frogPos.x - frogWidth/2  >= grayCarPos.x - carWidth/2 
		&& frogPos.x - frogWidth/2 <= grayCarPos.x + carWidth/2) &&
		(frogPos.y - frogHeight/2 + 2 >= grayCarPos.y - carHeight/2 
		&& frogPos.y - frogHeight/2 + 2 <= grayCarPos.y + carHeight/2)) || 
		
		((frogPos.x + frogWidth/2  >= grayCarPos.x - carWidth/2 
		&& frogPos.x + frogWidth/2 <= grayCarPos.x + carWidth/2) &&
		(frogPos.y - frogHeight/2 + 2 >= grayCarPos.y - carHeight/2 
		&& frogPos.y - frogHeight/2 + 2 <= grayCarPos.y + carHeight/2)) ||
		
		((frogPos.x - frogWidth/2  >= grayCarPos.x - carWidth/2 
		&& frogPos.x - frogWidth/2 <= grayCarPos.x + carWidth/2) &&
		(frogPos.y + frogHeight/2 - 2 >= grayCarPos.y - carHeight/2 
		&& frogPos.y + frogHeight/2 - 2 <= grayCarPos.y + carHeight/2)) ||
		
		((frogPos.x + frogWidth/2  >= grayCarPos.x - carWidth/2 
		&& frogPos.x + frogWidth/2 <= grayCarPos.x + carWidth/2) &&
		(frogPos.y + frogHeight/2 - 2 >= grayCarPos.y - carHeight/2 
		&& frogPos.y + frogHeight/2 - 2 <= grayCarPos.y + carHeight/2))
		):
			print("game over")
			gameRunning = false
			
	var redCarId = 0
	for redCar in carArray:
		var redCarPos = get_node(redCar).get_pos()
		var frogPos = get_node("frog").get_pos()
		if (((frogPos.x - frogWidth/2  >= redCarPos.x - carWidth/2 
		&& frogPos.x - frogWidth/2 <= redCarPos.x + carWidth/2) &&
		(frogPos.y - frogHeight/2 + 2 >= redCarPos.y - carHeight/2 
		&& frogPos.y - frogHeight/2 + 2 <= redCarPos.y + carHeight/2)) || 
		
		((frogPos.x + frogWidth/2  >= redCarPos.x - carWidth/2 
		&& frogPos.x + frogWidth/2 <= redCarPos.x + carWidth/2) &&
		(frogPos.y - frogHeight/2 + 2 >= redCarPos.y - carHeight/2 
		&& frogPos.y - frogHeight/2 + 2 <= redCarPos.y + carHeight/2)) ||
		
		((frogPos.x - frogWidth/2  >= redCarPos.x - carWidth/2 
		&& frogPos.x - frogWidth/2 <= redCarPos.x + carWidth/2) &&
		(frogPos.y + frogHeight/2 - 2 >= redCarPos.y - carHeight/2 
		&& frogPos.y + frogHeight/2 - 2 <= redCarPos.y + carHeight/2)) ||
		
		((frogPos.x + frogWidth/2  >= redCarPos.x - carWidth/2 
		&& frogPos.x + frogWidth/2 <= redCarPos.x + carWidth/2) &&
		(frogPos.y + frogHeight/2 - 2 >= redCarPos.y - carHeight/2 
		&& frogPos.y + frogHeight/2 - 2 <= redCarPos.y + carHeight/2))
		):
			print("game over")
			gameRunning = false
			
	var redCar2Id = 0
	for redCar2 in redCar2Array:
		var redCar2Pos = get_node(redCar2).get_pos()
		var frogPos = get_node("frog").get_pos()
		if (((frogPos.x - frogWidth/2  >= redCar2Pos.x - carWidth/2 
		&& frogPos.x - frogWidth/2 <= redCar2Pos.x + carWidth/2) &&
		(frogPos.y - frogHeight/2 + 2 >= redCar2Pos.y - carHeight/2 
		&& frogPos.y - frogHeight/2 + 2 <= redCar2Pos.y + carHeight/2)) || 
		
		((frogPos.x + frogWidth/2  >= redCar2Pos.x - carWidth/2 
		&& frogPos.x + frogWidth/2 <= redCar2Pos.x + carWidth/2) &&
		(frogPos.y - frogHeight/2 + 2 >= redCar2Pos.y - carHeight/2 
		&& frogPos.y - frogHeight/2 + 2 <= redCar2Pos.y + carHeight/2)) ||
		
		((frogPos.x - frogWidth/2  >= redCar2Pos.x - carWidth/2 
		&& frogPos.x - frogWidth/2 <= redCar2Pos.x + carWidth/2) &&
		(frogPos.y + frogHeight/2 - 2 >= redCar2Pos.y - carHeight/2 
		&& frogPos.y + frogHeight/2 - 2 <= redCar2Pos.y + carHeight/2)) ||
		
		((frogPos.x + frogWidth/2  >= redCar2Pos.x - carWidth/2 
		&& frogPos.x + frogWidth/2 <= redCar2Pos.x + carWidth/2) &&
		(frogPos.y + frogHeight/2 - 2 >= redCar2Pos.y - carHeight/2 
		&& frogPos.y + frogHeight/2 - 2 <= redCar2Pos.y + carHeight/2))
		):
			print("game over")
			gameRunning = false
			
	var blueCar2Id = 0
	for blueCar2 in blueCar2Array:
		var blueCar2Pos = get_node(blueCar2).get_pos()
		var frogPos = get_node("frog").get_pos()
		if (((frogPos.x - frogWidth/2  >= blueCar2Pos.x - carWidth/2 
		&& frogPos.x - frogWidth/2 <= blueCar2Pos.x + carWidth/2) &&
		(frogPos.y - frogHeight/2 + 2 >= blueCar2Pos.y - carHeight/2 
		&& frogPos.y - frogHeight/2 + 2 <= blueCar2Pos.y + carHeight/2)) || 
		
		((frogPos.x + frogWidth/2  >= blueCar2Pos.x - carWidth/2 
		&& frogPos.x + frogWidth/2 <= blueCar2Pos.x + carWidth/2) &&
		(frogPos.y - frogHeight/2 + 2 >= blueCar2Pos.y - carHeight/2 
		&& frogPos.y - frogHeight/2 + 2 <= blueCar2Pos.y + carHeight/2)) ||
		
		((frogPos.x - frogWidth/2  >= blueCar2Pos.x - carWidth/2 
		&& frogPos.x - frogWidth/2 <= blueCar2Pos.x + carWidth/2) &&
		(frogPos.y + frogHeight/2 - 2 >= blueCar2Pos.y - carHeight/2 
		&& frogPos.y + frogHeight/2 - 2 <= blueCar2Pos.y + carHeight/2)) ||
		
		((frogPos.x + frogWidth/2  >= blueCar2Pos.x - carWidth/2 
		&& frogPos.x + frogWidth/2 <= blueCar2Pos.x + carWidth/2) &&
		(frogPos.y + frogHeight/2 - 2 >= blueCar2Pos.y - carHeight/2 
		&& frogPos.y + frogHeight/2 - 2 <= blueCar2Pos.y + carHeight/2))
		):
			print("game over")
			gameRunning = false
			
			
			
func newCar():
	carCount = carCount + 1
	print("car")
	var car_instance = car.instance()
	car_instance.set_name("car" + str(carCount))
	add_child(car_instance)
	var carPos = get_node("car"+ str(carCount)).get_pos()
	carPos.y = 425
	carPos.x = bgWidth
	get_node("car"+ str(carCount)).set_pos(carPos)
	carArray.push_back("car"+ str(carCount))
	print(carArray)
	
func newGrayCar():
	grayCarCount= grayCarCount + 1
	print("grayCar")
	var grayCar_instance = grayCar.instance()
	grayCar_instance.set_name("grayCar" + str(grayCarCount))
	add_child(grayCar_instance)
	var grayCarPos = get_node("grayCar"+ str(grayCarCount)).get_pos()
	grayCarPos.y = 350 + carHeight/2
	grayCarPos.x = bgWidth
	get_node("grayCar"+ str(grayCarCount)).set_pos(grayCarPos)
	grayCarArray.push_back("grayCar"+ str(grayCarCount))
	print(grayCarArray)
	
func newWood():
	woodCount = woodCount + 1
	print("wood")
	var wood_instance = wood.instance()
	wood_instance.set_name("wood" + str(woodCount))
	add_child(wood_instance)
	move_child(wood_instance, 1)
	var woodPos = get_node("wood"+ str(woodCount)).get_pos()
	woodPos.y = 200
	woodPos.x = bgWidth
	get_node("wood"+ str(woodCount)).set_pos(woodPos)
	woodArray.push_back("wood"+ str(woodCount))
	print(woodArray)
	
func newBlueCar2():
	blueCar2Count= blueCar2Count + 1
	print("blueCar2")
	var blueCar2_instance = blueCar2.instance()
	blueCar2_instance.set_name("blueCar2" + str(blueCar2Count))
	add_child(blueCar2_instance)
	var blueCar2Pos = get_node("blueCar2"+ str(blueCar2Count)).get_pos()
	blueCar2Pos.y = 450 + carHeight/2
	blueCar2Pos.x = 0
	get_node("blueCar2"+ str(blueCar2Count)).set_pos(blueCar2Pos)
	blueCar2Array.push_back("blueCar2"+ str(blueCar2Count))
	print(blueCar2Array)
	
func newRedCar2():
	redCar2Count= redCar2Count + 1
	print("redCar2")
	var redCar2_instance = redCar2.instance()
	redCar2_instance.set_name("redCar2" + str(redCar2Count))
	add_child(redCar2_instance)
	var redCar2Pos = get_node("redCar2"+ str(redCar2Count)).get_pos()
	redCar2Pos.y = 500 + carHeight/2
	redCar2Pos.x = 0
	get_node("redCar2"+ str(redCar2Count)).set_pos(redCar2Pos)
	redCar2Array.push_back("redCar2"+ str(redCar2Count))
	print(redCar2Array)
	
func _on_jumpdelay_timeout():
	canJump = true
