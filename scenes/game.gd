extends Node2D

var enemy = preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() # Replace with function body.

func _on_Timer_timeout():
	#var rng = RandomNumberGenerator.new()
	#rng.randomize()
	#
	#$Path2D/PathFollow2D.offset = rng.randi_range(0, 3664)
	#var instance = enemy.instance()
	#
	#instance.global_position = $Path2D/PathFollow2D/Marker2D.global_position
	#add_child(instance)
	#print(instance.global_position)
	print("hi")
