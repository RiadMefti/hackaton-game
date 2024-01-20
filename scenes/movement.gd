extends CharacterBody2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()

func _ready():
	$AnimatedSprite2D.play("front_idle")



	#
#func play_anim(movement):
	#var dir = current_dir
	#var anim = $AnimatedSprite2D
	#
	#if dir == "right":
		#anim.flip_h = false
		#if movement == 1:
			#anim.play("side_walk")
		#elif movement == 0:
			#anim.play("side_idle")
	#if dir == "left":
		#anim.flip_h = true
		#if movement == 1:
			#anim.play("side_walk")
		#elif movement == 0:
			#anim.play("side_idle")
	#if dir == "down":
		#anim.flip_h = true
		#if movement == 1:
			#anim.play("front_walk")
		#elif movement == 0:
			#anim.play("front_idle")
	#if dir == "up":
		#anim.flip_h = true
		#if movement == 1:
			#anim.play("back_walk")
		#elif movement == 0:
			#anim.play("back_idle")
