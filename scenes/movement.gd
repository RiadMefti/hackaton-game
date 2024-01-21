extends CharacterBody2D

@export var speed = 400
var LaserScene = preload("res://scenes/laser.tscn")
var enemy_scene = preload("res://scenes/enemy.tscn")
var health= 3
var wave = 0
var current_spawned_gooses = 0
var waves = [10,20,50,1000000000]
func spawn_enemy():
	var enemy_position = get_random_position_on_perimeter()
	var enemy = enemy_scene.instantiate()
	enemy.global_position = enemy_position
	get_parent().get_parent().add_child(enemy)



func start_wave(wave_size):
	for i in range(wave_size):
		spawn_enemy()

func _on_wave_timer_timeout(wave_size):
	for i in range(wave_size):
		spawn_enemy()
	# You can also decrement wave_size here if you want to control the number of enemies per wave.
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
	healthIcon.visibwlde = false
	damage.visible = true
	health = health -1
func get_random_position_on_perimeter():
	var point = Vector2()
	var side = randi() % 4  # Randomly select a side (0-3)

	if side == 0:  # Top edge
		point.x = -1000 + randi() % 2000  # Random position between -1000 and 1000
		point.y = -500
	elif side == 1:  # Right edge
		point.x = 1000
		point.y = -500 + randi() % 1000  # Random position between -500 and 500
	elif side == 2:  # Bottom edge
		point.x = -1000 + randi() % 2000  # Random position between -1000 and 1000
		point.y = 500
	elif side == 3:  # Left edge
		point.x = -1000
		point.y = -500 + randi() % 1000  # Random position between -500 and 500

	return point

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
	
func change_wave_label(label_name):
	var canvasLayer = get_parent().get_node("CanvasLayer")
	var label = canvasLayer.get_node("Label")
	label.text = label_name
	
func _ready():
	change_wave_label("Wave #1")
	
func _process(delta):
	shoot()
	#if Input.is_action_just_pressed("shoot"):
		#print("shoot")  # Assuming 'ui_accept' is bound to the space bar
		#var laser = LaserScene.instance()
		#laser.position = self.position  # Start the laser at the character's position
		#get_parent().add_child(laser)  # Add the laser to the game world

func newWave():
	if(wave != 2):
		wave+=1
		change_wave_label("Wave #" + str(wave+1))
	elif(wave==3):
		change_wave_label("Infinite WAVES")
func _on_timer_timeout():
	if(current_spawned_gooses == waves[wave]):
		return
	start_wave(5)
	current_spawned_gooses +=5
