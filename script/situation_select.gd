extends Control
@onready var situation_1: TextureRect = $g1/Situation_1
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var focus_situation = 0
@onready var is_pressed = false
@onready var is_pressed2 = false
@onready var is_pressed3 = false
@onready var is_choose = false
@onready var is_can_go = false
@onready var label: Label = $Label
@onready var situation = 0
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2
@onready var animation_player_3: AnimationPlayer = $TextureRect4/AnimationPlayer
@onready var texture_rect_4: TextureRect = $TextureRect4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.change_music("res://asset/Level-select/Sound-start.ogg")
	Global.play_with_fade()
	animation_player.play("fade_out_2_2")
	animation_player_3.play("start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(focus_situation)
	pass

func _on_situation_1_mouse_entered() -> void:
	situation_1.modulate.a = 0.68
	focus_situation = 1
	situation = 1 
	
func _on_situation_1_mouse_exited() -> void:
	situation_1.modulate.a = 1
	focus_situation = 0
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and focus_situation != 0 and is_pressed == false:
		is_pressed = true
		label.text = "      Start "
		animation_player.play("fade_out")
		
	if event is InputEventMouseButton and event.pressed and  is_pressed2 == false:
		is_pressed2 = true
		animation_player.play("fade_out2")
		animation_player_3.play("end")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out_2_2" :
		is_choose = true
		
	if anim_name == "fade_out2" :
		animation_player_3.play("end")
		Global.change_music("res://asset/Lobby/situation_bg_music.ogg")
		Global.play_with_fade()
		texture_rect_4.visible = false
		audio_stream_player_2.stream = preload("res://asset/Lobby/situation_1.ogg")
		audio_stream_player_2.play()
	if anim_name == "fade_out3" :
		ScenesManager.start_quiz(situation)


func _on_audio_stream_player_finished() -> void:
	pass

	


func _on_audio_stream_player_2_finished() -> void:
	is_pressed3 = true
	animation_player.play("fade_out3")
	


func _on_animation_player_animation_finished_3(anim_name: StringName) -> void:
	if anim_name == "start" :
		animation_player_3.play("focus")
