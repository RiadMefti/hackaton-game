extends CharacterBody2D

var speed = 100
var player = null
var player_chase = false
var hit = false

func _physics_process(delta):
	if player_chase:
		var direction = "side"
		position += (player.position - position) / speed
		if hit:
			
			player.killGoose()
			self.queue_free()
			
		#update direction
		if position.x < player.position.x and position.y < player.position.y + 75 and position.y > player.position.y - 75:
			direction = "left"
		elif position.x > player.position.x and position.y < player.position.y + 75 and position.y > player.position.y - 75:
			direction = "right"
		elif position.y > player.position.y and position.x < player.position.x + 50 and position.x > player.position.x - 50:
			direction = "up"
		elif position.y < player.position.y and position.x < player.position.x + 50 and position.x > player.position.x - 50:
			direction = "down"
		elif position.y > player.position.y + 75 and position.x < player.position.x - 50:
			direction = "verR"
		elif position.y > player.position.y + 75 and position.x > player.position.x + 50:
			direction = "verL"
		elif position.y < player.position.y - 75 and position.x < player.position.x - 50:
			direction = "diaR"
		elif position.y < player.position.y - 75 and position.x > player.position.x + 50:
			direction = "diaL"
		playanim(direction)
	

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	

func playanim(dir):
	var anim = $AnimatedSprite2D
	if dir == "left":
		anim.flip_h = false
		anim.play("side_walk")
	if dir == "right":
		anim.flip_h = true
		anim.play("side_walk")
	if dir == "down":
		anim.flip_h = false
		anim.play("front_walk")
	if dir == "up":
		anim.flip_h = false
		anim.play("back_walk")
	if dir == "diaR":
		anim.flip_h = false
		anim.play("diaR_walk")
	if dir == "diaL":
		anim.flip_h = true
		anim.play("diaR_walk")
	if dir == "verL":
		anim.flip_h = false
		anim.play("verL_walk")
	if dir == "verR":
		anim.flip_h = false
		anim.play("verR_walk")
	


func _on_attack_area_area_entered(area):
	if(area.name =="Area2D"):
		area.get_parent().queue_free()
		hit = true
