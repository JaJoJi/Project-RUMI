extends Control

@onready var bg: TextureRect = $Bg
@onready var ttp_animation: AnimationPlayer = $"ttp-animation"
@onready var transition: AnimationPlayer = $transition
@onready var is_can_go_next = false
@onready var is_pressed = false
@onready var lbs = preload("res://asset/Lobby/Lobby.ogg")
@onready var next_scene = preload("res://scene/Explanation.tscn")
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fade_in")
	bg.visible = true
	audio_stream_player.stream = lbs
	audio_stream_player.play()
	ttp_animation.play("tts_go_up")
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and is_can_go_next == true and is_pressed == false:
		is_pressed = true
		transition.play("fade_out")


func _on_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out" :
		get_tree().change_scene_to_packed(next_scene)
	if anim_name == "fade_in" :
		is_can_go_next = true	


func _on_ttpanimation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "tts_go_up" :
		ttp_animation.play("tts_Blink")
