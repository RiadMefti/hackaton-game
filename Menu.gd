extends Control 
#Play button
func _on_play_pressed():
	get_tree().change_scene_to_file("res://GameMenu/node_2d.tscn")
	


#Rules button
func _on_rules_pressed():
	pass # Replace with function body.


#Exit button 
func _on_quit_pressed():

	get_tree().quit
