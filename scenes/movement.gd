extends CharacterBody2D

@export var speed = 400
var LaserScene = preload("res://scenes/laser.tscn")
var health= 3

func receive_damage():
	var canvasLayer = get_parent().get_node("CanvasLayer")
	var sprit1 = canvasLayer.get_node("health3")
	var sprit2 = canvasLayer.get_node("dead3")
	sprit1.visible = false
	sprit2.visible = true
	
	
	var stringHealth = "health" + str(health)
	var stringDead = "dead"+ str(health)
	var  healthIcon = canvasLayer.get_node(stringHealth)
	var damage = canvasLayer.get_node(stringDead)
	healthIcon.visibwle = false
	damage.visible = true
	health = health -1

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
func updateAnim():
	var direction = "up"
	var movement = 0
	if velocity.x < 0: 
		
		direction = "left"
		movement = 1
	elif velocity.x > 0: 
		direction = "right"
		movement = 1
	elif velocity.y < 0: 
		direction = "up"
		movement = 1
	elif velocity.y > 0: 
		direction = "down"
		movement = 1
	elif velocity.x ==0 and velocity.y==0 :
		direction = "idle"
		movement = 0
	play_anim(direction, movement)
		
	
func play_anim(dir, movement):
	var anim = $AnimatedSprite2D
	if dir == "idle":
		anim.play("front_idle")
	if dir == "right":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	if dir == "up":
		anim.flip_h = true
		anim.play("back_walk")
func shoot():

	if Input.is_action_just_pressed("shoot"):
		receive_damage()
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if input_direction != Vector2.ZERO:
			var laser = LaserScene.instantiate()
			laser.position = position  # Start the laser at the character's position
			get_parent().add_child(laser)
			
			
			
			if(input_direction.x ==1):
				laser.rotation_degrees = 90
				
			elif (input_direction.x == -1):
				laser.rotation_degrees = -90
			elif (input_direction.x * input_direction.y > 0):
				laser.rotation_degrees = -45
			elif (input_direction.x * input_direction.y < 0):
				laser.rotation_degrees = 45
			print(input_direction)
			laser.speed = 800 * input_direction  # Set the laser's speed to move left
		else:
			var laser  = LaserScene.instantiate()
			laser.position = position  # Start the laser at the character's position
			get_parent().add_child(laser)
			var shooting_vector = Vector2.ZERO 
			shooting_vector.y = 800
			laser.speed = shooting_vector
	
func _physics_process(delta):
	get_input()
	updateAnim()
	move_and_slide()
	
	
	
	
func _process(delta):
	shoot()
	#if Input.is_action_just_pressed("shoot"):
		#print("shoot")  # Assuming 'ui_accept' is bound to the space bar
		#var laser = LaserScene.instance()
		#laser.position = self.position  # Start the laser at the character's position
		#get_parent().add_child(laser)  # Add the laser to the game world
