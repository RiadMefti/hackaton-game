extends Control




func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://GameMenu/menu.tscn")





func _on_button_pressed():
	get_tree().quit()
