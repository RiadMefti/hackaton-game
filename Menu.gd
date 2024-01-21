extends Control 
#Play button
func _on_play_pressed():
		get_tree().change_scene_to_file("res://scenes/TitleScreen.tscn")
	


#Rules button
func _on_rules_pressed():
	get_tree().change_scene_to_file("res://GameMenu/Rules.tscn")


#Exit button 
func _on_quit_pressed():
	get_tree().quit()
