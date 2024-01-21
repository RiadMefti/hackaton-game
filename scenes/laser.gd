extends Node2D


var speed: Vector2 = Vector2.ZERO  # Default speed is zero


func _process(delta):
	position += speed * delta
	if position.x > get_viewport_rect().size.x:
		queue_free()  # Delete the laser when it goes off-screen


func _on_area_2d_area_entered(area):
	self.queue_free()
