extends Node

var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()
var fade_time := 1.0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(audio_player)
	audio_player.volume_db = -50
	audio_player.stream = preload("res://asset/Lobby/Explanation.ogg")
	if audio_player.stream is AudioStream:
		audio_player.stream.loop = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_with_fade():
	if audio_player.playing:
		return
	audio_player.play()
	# fade in จาก -80 dB ถึง 0 dB
	_create_fade_tween(audio_player.volume_db, -15)
	
func stop_with_fade():
	if not audio_player.playing:
		return
	# fade out จาก volume ปัจจุบัน ไป -80 dB แล้วหยุด
	_create_fade_tween(audio_player.volume_db, -80, true)
	
func change_music(path):
	audio_player.stream = load(path)
	if audio_player.stream is AudioStream:
		audio_player.stream.loop = true
	
func _create_fade_tween(from_db: float, to_db: float, stop_after := false):
	var tween := create_tween()
	tween.tween_property(audio_player, "volume_db", to_db, fade_time).from(from_db)
	if stop_after:
		tween.tween_callback(Callable(audio_player, "stop"))
