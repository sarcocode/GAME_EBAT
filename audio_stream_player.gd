extends Node

@onready var background_music_player = $BackgroundMusicPlayer
var is_signal_connected = false

func _ready():
	# Ждем один кадр, чтобы убедиться, что узел инициализирован
	await get_tree().process_frame
	
	# Проверяем, что background_music_player не null
	if background_music_player == null:
		print("Error: background_music_player is null!")
		return
	
	# Подключаем сигнал finished, только если он ещё не подключен
	if not is_signal_connected:
		background_music_player.finished.connect(_on_music_finished)
		is_signal_connected = true
	
	# Воспроизводим музыку при запуске
	play_music()

func play_music():
	if not background_music_player.playing:
		background_music_player.play()

func stop_music():
	if background_music_player.playing:
		background_music_player.stop()

func _on_music_finished():
	# Зацикливаем музыку
	background_music_player.play()
