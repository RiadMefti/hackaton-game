extends CharacterBody2D

@export var speed = 400

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

func _physics_process(delta):
	get_input()
	updateAnim()
	move_and_slide()
