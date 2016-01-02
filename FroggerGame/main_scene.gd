
extends Node2D

var isButtonPressed = false
var bgWidth = 750
var bgHeigh = 650
var frogWidth = 50
var frogHeight = 50
var bigWoodWidth = 200
var woodWidth = 150
var smallWoodWidth = 100
var woodHeight = 50
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
var timeSinceLastGrayCar = 0
var blueCar2 = preload ("res://blue_car2.xml")
var blueCar2Count = 0;
var blueCar2Array = []
var timeSinceLastBlueCar2 = 0
var redCar2 = preload ("res://red_car2.xml")
var redCar2Count = 0
var redCar2Array = []
var timeSinceLastRedCar2 = 0
var wood = preload ("res://wood.xml")
var woodCount = 0;
var woodArray = []
var timeSinceLastWood = 0
var bigWood = preload ("res://bigWood.xml")
var bigWoodCount = 0;
var bigWoodArray = []
var timeSinceLastBigWood = 0
var smallWood = preload ("res://smallWood.xml")
var smallWoodCount = 0;
var smallWoodArray = []
var timeSinceLastSmallWood = 0
var turtle = preload ("res://turtle.xml")
var turtle2 = preload ("res://turtle.xml")
var turtleCount = 0
var turtleArray = []
var turtleArray2 = []
var timeSinceLastTurtle = 0
var timeSinceLastTurtle2 = 0

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
				_reset_woods()
				canJump = false
				get_node("jump-delay").start()
				frogPos.y = frogPos.y - frogHeight
				#print("UP!")
				isButtonPressed = true
				frog.set_rot(PI*2)
				get_node("frog").set_pos(frogPos)
				if (int(floor(frogPos.x - frogWidth / 2)) % frogWidth != 0):
					putFrogIntoSpace()
	else:
		isButtonPressed = false
	if Input.is_action_pressed("ui_left"):
		if isButtonPressed == false && frogPos.x > frogWidth/2:
			if (canJump == true):
				if (frog.wood != null):
					frog.wood.frogPositionOnWood = frog.wood.frogPositionOnWood - 1
				canJump = false
				get_node("jump-delay").start()
				frogPos.x = frogPos.x - frogWidth
				
				#print("LEFT!")
				isButtonPressed = true
				frog.set_rot(PI/2)
				get_node("frog").set_pos(frogPos)
	else:
		isButtonPressed = false
	
	if Input.is_action_pressed("ui_right"):
		if isButtonPressed == false && frogPos.x < bgWidth:
			if (canJump == true):
				if (frog.wood != null):
					frog.wood.frogPositionOnWood = frog.wood.frogPositionOnWood + 1
				canJump = false
				get_node("jump-delay").start()
				frogPos.x = frogPos.x + frogWidth
				#print("RIGHT!")
				isButtonPressed = true
				frog.set_rot(PI*1.5)
				get_node("frog").set_pos(frogPos)
	else:
		isButtonPressed = false
	
	if Input.is_action_pressed("ui_down"):
		print (frogPos.y);
		if isButtonPressed == false && frogPos.y < (bgHeigh - frogHeight / 2):
			if (canJump == true):
				_reset_woods()
				canJump = false
				get_node("jump-delay").start()
				frogPos.y = frogPos.y + frogHeight
				#print("DOWN!")
				isButtonPressed = true
				frog.set_rot(PI*3)
				get_node("frog").set_pos(frogPos)
				if (int(floor(frogPos.x - frogWidth / 2)) % frogWidth != 0):
					putFrogIntoSpace()
	else:
		isButtonPressed = false
	
	
	
	var carId = 0
	for car in carArray:
		var carPos = get_node(car).get_pos()
		carPos.x = carPos.x - 300 * delta
		get_node(car).set_pos(carPos)
		if carPos.x > bgWidth:
			get_node(car).queue_free()
			carArray.remove(carId)
		carId = carId + 1
	
	timeSinceLastCar = timeSinceLastCar + delta
	if (timeSinceLastCar > 1.5):
		newCar()
		timeSinceLastCar = 0
		
	var grayCarId = 0
	for grayCar in grayCarArray:
		var grayCarPos = get_node(grayCar).get_pos()
		grayCarPos.x = grayCarPos.x - 250 * delta
		get_node(grayCar).set_pos(grayCarPos)
		if grayCarPos.x > bgWidth:
			get_node(grayCar).queue_free()
			grayCarArray.remove(grayCarId)
		grayCarId = grayCarId + 1
	
	timeSinceLastGrayCar = timeSinceLastGrayCar + delta
	if (timeSinceLastGrayCar > 1.5):
		newGrayCar()
		timeSinceLastGrayCar = 0
		
	var blueCar2Id = 0
	for blueCar2 in blueCar2Array:
		var blueCar2Pos = get_node(blueCar2).get_pos()
		blueCar2Pos.x = blueCar2Pos.x + 250 * delta
		get_node(blueCar2).set_pos(blueCar2Pos)
		if blueCar2Pos.x < 0:
			get_node(blueCar2).queue_free()
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
			get_node(blueCar2).queue_free()
			redCar2Array.remove(redCar2Id)
		redCar2Id = redCar2Id + 1
	
	timeSinceLastRedCar2 = timeSinceLastRedCar2 + delta
	if (timeSinceLastRedCar2 > 3):
		newRedCar2()
		timeSinceLastRedCar2 = 0
		
	var woodId = 0
	for wood in woodArray:
		var woodPos = get_node(wood).get_pos()
		woodPos.x = woodPos.x + 120 * delta
		if (get_node(wood).isFrogOnWood == true):
			var newX = woodPos.x - woodWidth / 2 + frogWidth * get_node(wood).frogPositionOnWood + frogWidth / 2
			frog.set_pos(Vector2(newX, frog.get_pos().y))
		get_node(wood).set_pos(woodPos)
		if woodPos.x < 0:
			get_node(wood).queue_free()
			woodArray.remove(woodId)
		woodId = woodId + 1
		
	timeSinceLastWood = timeSinceLastWood + delta
	if (timeSinceLastWood > 3):
		newWood()
		timeSinceLastWood = 0
		
	var bigWoodId = 0
	for bigWood in bigWoodArray:
		var bigWoodPos = get_node(bigWood).get_pos()
		bigWoodPos.x = bigWoodPos.x + 120 * delta
		if (get_node(bigWood).isFrogOnWood == true):
			var newX = bigWoodPos.x - bigWoodWidth / 2 + frogWidth * get_node(bigWood).frogPositionOnWood + frogWidth / 2
			frog.set_pos(Vector2(newX, frog.get_pos().y))
		get_node(bigWood).set_pos(bigWoodPos)
		if bigWoodPos.x < 0:
			get_node(bigWood).queue_free()
			bigWoodArray.remove(bigWoodId)
		bigWoodId = bigWoodId + 1
		
	timeSinceLastBigWood = timeSinceLastBigWood + delta
	if (timeSinceLastBigWood > 3):
		newBigWood()
		timeSinceLastBigWood = 0
		
	var smallWoodId = 0
	for smallWood in smallWoodArray:
		var smallWoodPos = get_node(smallWood).get_pos()
		smallWoodPos.x = smallWoodPos.x + 60 * delta
		if (get_node(smallWood).isFrogOnWood == true):
			var newX = smallWoodPos.x - smallWoodWidth / 2 + frogWidth * get_node(smallWood).frogPositionOnWood + frogWidth / 2
			frog.set_pos(Vector2(newX, frog.get_pos().y))
		get_node(smallWood).set_pos(smallWoodPos)
		if smallWoodPos.x < 0:
			get_node(smallWood).queue_free()
			smallWoodArray.remove(smallWoodId)
		smallWoodId = smallWoodId + 1
	timeSinceLastSmallWood = timeSinceLastSmallWood + delta
	if (timeSinceLastSmallWood > 3):
		newSmallWood()
		timeSinceLastSmallWood = 0
		
	var turtleId = 0
	for turtle in turtleArray:
		var turtlePos = get_node(turtle).get_pos()
		turtlePos.x = turtlePos.x - 90 * delta
		get_node(turtle).set_pos(turtlePos)
		if turtlePos.x > bgWidth:
			get_node(turtle).queue_free()
			turtleArray.remove(turtleId)
		turtleId = turtleId + 1
		
	timeSinceLastTurtle = timeSinceLastTurtle + delta
	if (timeSinceLastTurtle > 3):
		newTurtle(0, 250)
		newTurtle(1, 250)
		newTurtle(2, 250)
		timeSinceLastTurtle = 0
		
	var turtleId2 = 0
	for turtle2 in turtleArray2:
		var turtlePos = get_node(turtle2).get_pos()
		turtlePos.x = turtlePos.x - 150 * delta
		get_node(turtle2).set_pos(turtlePos)
		if turtlePos.x > bgWidth:
			get_node(turtle2).queue_free()
			turtleArray2.remove(turtleId2)
		turtleId2 = turtleId2 + 1
		
	timeSinceLastTurtle2 = timeSinceLastTurtle2 + delta
	if (timeSinceLastTurtle2 > 1.5):
		newTurtle(0, 100)
		newTurtle(1, 100)
		timeSinceLastTurtle2 = 0
		
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
			_reset_frog_pos()
			#print("game over")
			#gameRunning = false
			
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
			_reset_frog_pos()
			#print("game over")
			#gameRunning = false
			
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
			_reset_frog_pos()
			#print("game over")
			#gameRunning = false
			
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
			_reset_frog_pos()
			#print("game over")
			#gameRunning = false
			
	var woodId = 0
	for wood in woodArray:
		var woodPos = get_node(wood).get_pos()
		var frogPos = get_node("frog").get_pos()
		if (((frogPos.x - frogWidth/2  >= woodPos.x - woodWidth/2 
		&& frogPos.x - frogWidth/2 <= woodPos.x + woodWidth/2) &&
		(frogPos.y - frogHeight/2 + 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y - frogHeight/2 + 5 <= woodPos.y + woodHeight/2)) || 
		
		((frogPos.x + frogWidth/2  >= woodPos.x - woodWidth/2 
		&& frogPos.x + frogWidth/2 <= woodPos.x + woodWidth/2) &&
		(frogPos.y - frogHeight/2 + 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y - frogHeight/2 + 5 <= woodPos.y + woodHeight/2)) ||
		
		((frogPos.x - frogWidth/2  >= woodPos.x - woodWidth/2 
		&& frogPos.x - frogWidth/2 <= woodPos.x + woodWidth/2) &&
		(frogPos.y + frogHeight/2 - 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y + frogHeight/2 - 5 <= woodPos.y + woodHeight/2)) ||
		
		((frogPos.x + frogWidth/2  >= woodPos.x - woodWidth/2 
		&& frogPos.x + frogWidth/2 <= woodPos.x + woodWidth/2) &&
		(frogPos.y + frogHeight/2 - 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y + frogHeight/2 - 5 <= woodPos.y + woodHeight/2))
		):
			if (get_node(wood).isFrogOnWood == false):
				putFrogIntoWoodSpace(get_node(wood))
				frog.wood = get_node(wood)
				get_node(wood).isFrogOnWood = true
			#else :
				#frog.wood = null
			
	smallWoodId = 0
	for smallWood in smallWoodArray:
		var woodPos = get_node(smallWood).get_pos()
		var frogPos = get_node("frog").get_pos()
		if (((frogPos.x - frogWidth/2  >= woodPos.x - smallWoodWidth/2 
		&& frogPos.x - frogWidth/2 <= woodPos.x + smallWoodWidth/2) &&
		(frogPos.y - frogHeight/2 + 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y - frogHeight/2 + 5 <= woodPos.y + woodHeight/2)) || 
		
		((frogPos.x + frogWidth/2  >= woodPos.x - smallWoodWidth/2 
		&& frogPos.x + frogWidth/2 <= woodPos.x + smallWoodWidth/2) &&
		(frogPos.y - frogHeight/2 + 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y - frogHeight/2 + 5 <= woodPos.y + woodHeight/2)) ||
		
		((frogPos.x - frogWidth/2  >= woodPos.x - smallWoodWidth/2 
		&& frogPos.x - frogWidth/2 <= woodPos.x + smallWoodWidth/2) &&
		(frogPos.y + frogHeight/2 - 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y + frogHeight/2 - 5 <= woodPos.y + woodHeight/2)) ||
		
		((frogPos.x + frogWidth/2  >= woodPos.x - smallWoodWidth/2 
		&& frogPos.x + frogWidth/2 <= woodPos.x + smallWoodWidth/2) &&
		(frogPos.y + frogHeight/2 - 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y + frogHeight/2 - 5 <= woodPos.y + woodHeight/2))
		):
			if (get_node(smallWood).isFrogOnWood == false):
				putFrogIntoWoodSpace(get_node(smallWood))
				frog.wood = get_node(smallWood)
				get_node(smallWood).isFrogOnWood = true
			#else :
				#frog.wood = null
			
	var bigWoodId = 0
	for bigWood in bigWoodArray:
		var woodPos = get_node(bigWood).get_pos()
		var frogPos = get_node("frog").get_pos()
		if (((frogPos.x - frogWidth/2  >= woodPos.x - bigWoodWidth/2 
		&& frogPos.x - frogWidth/2 <= woodPos.x + bigWoodWidth/2) &&
		(frogPos.y - frogHeight/2 + 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y - frogHeight/2 + 5 <= woodPos.y + woodHeight/2)) || 
		
		((frogPos.x + frogWidth/2  >= woodPos.x - bigWoodWidth/2 
		&& frogPos.x + frogWidth/2 <= woodPos.x + bigWoodWidth/2) &&
		(frogPos.y - frogHeight/2 + 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y - frogHeight/2 + 5 <= woodPos.y + woodHeight/2)) ||
		
		((frogPos.x - frogWidth/2  >= woodPos.x - bigWoodWidth/2 
		&& frogPos.x - frogWidth/2 <= woodPos.x + bigWoodWidth/2) &&
		(frogPos.y + frogHeight/2 - 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y + frogHeight/2 - 5 <= woodPos.y + woodHeight/2)) ||
		
		((frogPos.x + frogWidth/2  >= woodPos.x - bigWoodWidth/2 
		&& frogPos.x + frogWidth/2 <= woodPos.x + bigWoodWidth/2) &&
		(frogPos.y + frogHeight/2 - 5 >= woodPos.y - woodHeight/2 
		&& frogPos.y + frogHeight/2 - 5 <= woodPos.y + woodHeight/2))
		):
			if (get_node(bigWood).isFrogOnWood == false):
				putFrogIntoWoodSpace(get_node(bigWood))
				frog.wood = get_node(bigWood)
				get_node(bigWood).isFrogOnWood = true
			#else :
				#frog.wood = null
			
func newCar():
	carCount = carCount + 1
	#print("car")
	var car_instance = car.instance()
	car_instance.set_name("car" + str(carCount))
	add_child(car_instance)
	var carPos = get_node("car"+ str(carCount)).get_pos()
	carPos.y = 425
	carPos.x = bgWidth
	get_node("car"+ str(carCount)).set_pos(carPos)
	carArray.push_back("car"+ str(carCount))
	#print(carArray)
	
func newGrayCar():
	grayCarCount= grayCarCount + 1
	#print("grayCar")
	var grayCar_instance = grayCar.instance()
	grayCar_instance.set_name("grayCar" + str(grayCarCount))
	add_child(grayCar_instance)
	var grayCarPos = get_node("grayCar"+ str(grayCarCount)).get_pos()
	grayCarPos.y = 350 + carHeight/2
	grayCarPos.x = bgWidth
	get_node("grayCar"+ str(grayCarCount)).set_pos(grayCarPos)
	grayCarArray.push_back("grayCar"+ str(grayCarCount))
	#print(grayCarArray)
	
func newBlueCar2():
	blueCar2Count= blueCar2Count + 1
	#print("blueCar2")
	var blueCar2_instance = blueCar2.instance()
	blueCar2_instance.set_name("blueCar2" + str(blueCar2Count))
	add_child(blueCar2_instance)
	var blueCar2Pos = get_node("blueCar2"+ str(blueCar2Count)).get_pos()
	blueCar2Pos.y = 450 + carHeight/2
	blueCar2Pos.x = 0
	get_node("blueCar2"+ str(blueCar2Count)).set_pos(blueCar2Pos)
	blueCar2Array.push_back("blueCar2"+ str(blueCar2Count))
	#print(blueCar2Array)
	
func newRedCar2():
	redCar2Count= redCar2Count + 1
	#print("redCar2")
	var redCar2_instance = redCar2.instance()
	redCar2_instance.set_name("redCar2" + str(redCar2Count))
	add_child(redCar2_instance)
	var redCar2Pos = get_node("redCar2"+ str(redCar2Count)).get_pos()
	redCar2Pos.y = 500 + carHeight/2
	redCar2Pos.x = 0
	get_node("redCar2"+ str(redCar2Count)).set_pos(redCar2Pos)
	redCar2Array.push_back("redCar2"+ str(redCar2Count))
	#print(redCar2Array)
	
func newWood():
	woodCount = woodCount + 1
	#print("wood")
	var wood_instance = wood.instance()
	wood_instance.width = 150
	wood_instance.set_name("wood" + str(woodCount))
	add_child(wood_instance)
	move_child(wood_instance, 1)
	var woodPos = get_node("wood"+ str(woodCount)).get_pos()
	woodPos.y = 50 + 25
	woodPos.x = 0
	get_node("wood"+ str(woodCount)).set_pos(woodPos)
	woodArray.push_back("wood"+ str(woodCount))
	#print(woodArray)
	
func newSmallWood():
	smallWoodCount = smallWoodCount + 1
	#print("smallWood")
	var smallWood_instance = smallWood.instance()
	smallWood_instance.width = 100
	smallWood_instance.set_name("smallWood" + str(smallWoodCount))
	add_child(smallWood_instance)
	move_child(smallWood_instance, 1)
	var smallWoodPos = get_node("smallWood"+ str(smallWoodCount)).get_pos()
	smallWoodPos.y = 200 + 25
	smallWoodPos.x = 0
	get_node("smallWood"+ str(smallWoodCount)).set_pos(smallWoodPos)
	smallWoodArray.push_back("smallWood"+ str(smallWoodCount))
	#print(smallWoodArray)
	
func newBigWood():
	bigWoodCount = bigWoodCount + 1
	var bigWood_instance = bigWood.instance()
	bigWood_instance.width = 200
	bigWood_instance.set_name("bigWood" + str(bigWoodCount))
	add_child(bigWood_instance)
	move_child(bigWood_instance, 1)
	var bigWoodPos = get_node("bigWood"+ str(bigWoodCount)).get_pos()
	bigWoodPos.y = 150 + 25
	bigWoodPos.x = 0
	get_node("bigWood"+ str(bigWoodCount)).set_pos(bigWoodPos)
	bigWoodArray.push_back("bigWood"+ str(bigWoodCount))
	
func newTurtle(turtleNumber, y):
	turtleCount = turtleCount + 1
	#print("turtle")
	var turtle_instance = turtle.instance()
	turtle_instance.set_name("turtle" + str(turtleCount))
	add_child(turtle_instance)
	move_child(turtle_instance, 1)
	var turtlePos = get_node("turtle"+ str(turtleCount)).get_pos()
	turtlePos.y = y + 25
	turtlePos.x = bgWidth - turtleNumber * 50
	get_node("turtle"+ str(turtleCount)).set_pos(turtlePos)
	turtleArray.push_back("turtle"+ str(turtleCount))
	#print(turtleArray)
	
func putFrogIntoSpace():
	var frog = get_node("frog")
	var f = floor((frog.get_pos().x - frogWidth / 2) / frogWidth)
	var v = (frog.get_pos().x - frogWidth / 2) / frogWidth - f
	print(f*frogWidth)
	if (v < 0.5):
		frog.set_pos(Vector2((f + 1) * frogWidth - frogWidth / 2, frog.get_pos().y))
		
	else:
		frog.set_pos(Vector2((f + 2) * frogWidth - frogWidth / 2, frog.get_pos().y))
	
func putFrogIntoWoodSpace(wood):
	var frog = get_node("frog")
	var woodPos = wood.get_pos()
	var x_relation_wood = frog.get_pos().x - wood.get_pos().x - frogWidth / 2
	var f = floor(x_relation_wood / frogWidth)
	var v = (x_relation_wood) / frogWidth - f
	if (v < 0.5):
		print("frog position on wood: ", f)
		wood.frogPositionOnWood = f + 1
		var newX = woodPos.x - wood.width / 2 + frogWidth * wood.frogPositionOnWood + frogWidth / 2
		frog.set_pos(Vector2(newX, frog.get_pos().y))
	else:
		print("frog position on wood: ", f)
		wood.frogPositionOnWood = f + 2
		var newX = woodPos.x - wood.width / 2 + frogWidth * wood.frogPositionOnWood + frogWidth / 2
		frog.set_pos(Vector2(newX, frog.get_pos().y))
	
	
func _on_jumpdelay_timeout():
	canJump = true
	
func _reset_woods():
	get_node("frog").wood = null
	for wood in woodArray:
		var w = get_node(wood)
		w.isFrogOnWood = false
	for smallWood in smallWoodArray:
		var w = get_node(smallWood)
		w.isFrogOnWood = false
	for bigWood in bigWoodArray:
		var w = get_node(bigWood)
		w.isFrogOnWood = false


func _on_game_timer_timeout():
	var t = int(get_node("time").get_text())
	if (t != 0):
		get_node("time").set_text(str(t - 1))
	elif (t == 0):
		_reset_frog_pos()
		get_node("game_timer").stop()
	
func _reset_frog_pos():
	var frog = get_node("frog")
	var frogPos = frog.get_pos()
	frogPos.x = 375
	frogPos.y = bgWidth - 175
	frog.set_pos(frogPos)
	get_node("game_timer").start()
