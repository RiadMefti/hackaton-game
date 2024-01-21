extends AudioStreamPlayer2D

var audio_stream_player: AudioStreamPlayer2D

func _ready():
	audio_stream_player = $AudioStreamPlayer2D

func play_sound(audio_stream: AudioStream):
	audio_stream_player.stream = audio_stream
	audio_stream_player.play()

func stop_sound():
	audio_stream_player.stop()

# Singleton pattern
func _on_AudioManager_singleton():
	if self != get_tree().get_root().get_node("AudioManager"):
		queue_free()

func _on_preload():
	if get_tree().get_root().get_node("AudioManager"):
		queue_free()
	else:
		var audio_manager = preload("res://assets/Y2meta.app - Pixel Tunes (Royalty Free Game Music Pack) (128 kbps).mp3").instance()
		audio_manager.name = "AudioManager"
		get_tree().get_root().add_child(audio_manager)
