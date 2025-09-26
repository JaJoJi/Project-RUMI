extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var is_pressed = false
@onready var lbs = preload("res://asset/Lobby/Explanation.ogv")
@onready var lbs2 = preload("res://asset/Lobby/Explanation.ogg")
@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var texture_rect: TextureRect = $TextureRect
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("fade_in")
	video_stream_player.stream = lbs
	video_stream_player.play()
	Global.play_with_fade()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.pressed and is_pressed == false:
		#is_pressed = true
		#animation_player.play("fade_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name != "fade_in" :
		get_tree().change_scene_to_file("res://scene/situation_select.tscn")


func _on_video_stream_player_finished() -> void:
	texture_rect.visible = true


func _on_audio_stream_player_2_finished() -> void:
	is_pressed = true
	animation_player.play("fade_out")
