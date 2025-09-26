extends Control

@export var json_path : JSON 

@onready var Try_Again : VideoStreamPlayer = $Try_Again
@onready var Good_Job : VideoStreamPlayer = $Good_Job
@onready var Project_Icon : TextureRect = $Project_Icon
@onready var Timer_Count : Timer = $Timer
@onready var TA_Audio : AudioStreamPlayer = $Try_Again/TA_Audio
@onready var GJ_Audio : AudioStreamPlayer = $Good_Job/GJ_Audio
@onready var check_timer : Timer = $Timer2

@onready var Scenario_Node : Control = $Scenario_Node
@onready var Scenario_Tag : HBoxContainer = $Scenario_Node/Scenario_Block/Tag
@onready var Scenario_Index : TextEdit = $Scenario_Node/Scenario_Block/Tag/Index
@onready var Scenario_Block : VBoxContainer = $Scenario_Node/Scenario_Block
@onready var Scenario_Video : VideoStreamPlayer = $Scenario_Node/Scenario_Block/Scenario_Video
@onready var scenario_audio: AudioStreamPlayer = $Scenario_Node/Scenario_Block/Scenario_audio
@onready var scenario_idle : AudioStreamPlayer = $Scenario_Node/Scenario_Block/Idle
@onready var is_have_Scenario = false

@onready var Quiz_Node : Control = $Quiz_Node
@onready var Quiz_panel : TextEdit = $Quiz_Node/quiz_panel
@onready var Question_Tag : HBoxContainer = $Quiz_Node/quiz_panel/VBoxContainer/Tag
@onready var Index_question : TextEdit = $Quiz_Node/quiz_panel/VBoxContainer/Tag/Panel/Index
@onready var Question : RichTextLabel = $Quiz_Node/quiz_panel/VBoxContainer/VBoxContainer/Question
@onready var Button_A: Button = $Quiz_Node/quiz_panel/VBoxContainer/VBoxContainer/Hbox/VBox1/Button_A
@onready var Button_B: Button = $Quiz_Node/quiz_panel/VBoxContainer/VBoxContainer/Hbox/VBox2/Button_B
@onready var Button_C: Button = $Quiz_Node/quiz_panel/VBoxContainer/VBoxContainer/Hbox/VBox1/Button_C
@onready var Button_D: Button = $Quiz_Node/quiz_panel/VBoxContainer/VBoxContainer/Hbox/VBox2/Button_D
@onready var Quiz_img : TextureRect = $Quiz_Node/quiz_img
@onready var HBox : HBoxContainer = $Quiz_Node/quiz_panel/VBoxContainer/VBoxContainer/Hbox
@onready var VBox_Extra : VBoxContainer = $Quiz_Node/quiz_panel/VBox_Extra
@onready var ButtonA_Extra : Button = $Quiz_Node/quiz_panel/VBox_Extra/Button_Extra_A
@onready var ButtonB_Extra : Button = $Quiz_Node/quiz_panel/VBox_Extra/Button_Extra_B
@onready var ButtonC_Extra : Button = $Quiz_Node/quiz_panel/VBox_Extra/Button_Extra_C
@onready var ButtonD_Extra : Button = $Quiz_Node/quiz_panel/VBox_Extra/Button_Extra_D
@onready var Father : TextureRect = $Quiz_Node/Line/Father
@onready var quiz_audio : AudioStreamPlayer = $Quiz_Node/Quiz_audio
@onready var quiz_idle : AudioStreamPlayer = $Quiz_Node/Idle
@onready var choiceAC : VBoxContainer = $Quiz_Node/quiz_panel/VBoxContainer/VBoxContainer/Hbox/VBox1
@onready var choiceBD : VBoxContainer = $Quiz_Node/quiz_panel/VBoxContainer/VBoxContainer/Hbox/VBox2
@onready var all_question : VBoxContainer = $Quiz_Node/quiz_panel/VBoxContainer/VBoxContainer

@onready var Answer_Node : Control = $Answer_Node
@onready var Answer_Block : VBoxContainer = $Answer_Node/Answer
@onready var Answer_Video : VideoStreamPlayer = $Answer_Node/Answer/answer_video
@onready var Answer_Choice : Label = $Answer_Node/Answer/answer_choice
@onready var Answer_Desc : RichTextLabel = $Answer_Node/Answer/answer_description
@onready var Refer : RichTextLabel = $Answer_Node/Answer/refer
@onready var Answer_Texture : TextureRect = $Answer_Node/Answer/answer_texture
@onready var Video_Source : Label = $Answer_Node/Label
@onready var answer_audio: AudioStreamPlayer = $Answer_Node/Answer/answer_audio
@onready var Next_Answer : Button = $Answer_Node/NEXT
@onready var Replay_Answer : Button = $Answer_Node/REPLAY
@onready var Extra_Panel : Panel = $Answer_Node/Extra_img
@onready var Extra_img : TextureRect = $Answer_Node/Extra_img/answer_texture_extra
@onready var Label_Extra_img : Label = $Answer_Node/Extra_img/answer_texture_extra/Label
@onready var Nurse : TextureRect = $Answer_Node/Nurse
@onready var answer_idle : AudioStreamPlayer = $Answer_Node/Answer/Idle
@onready var back : Panel = $Answer_Node/Back_Panel
@onready var skip : Button = $Answer_Node/skip

@onready var END_Node : Control = $END
@onready var SCORE_END : Label = $END/SCORE
@onready var Ending : TextureRect = $END/Ending
@onready var is_pressed = false
@onready var end_idle : AudioStreamPlayer = $END/Idle
@onready var end_audio : AudioStreamPlayer = $END/end_audio

var situation = ScenesManager.situation
var point 
var score
var wrong_count
var max_score

var countdown_time = 3000
var pos_x_father = -46

var source 
var p

var answer_description

var select_button

var wrong = false
var sign = false
var run_text = ""

var SNS = [6,77,169,0,24,19,0,0,0,4,9,11,3,0,10,0,0,40,16,39,98]
var ASS = [23,26,0,29,25,18,0,3,0,4,6,0,15,5,4,0,10,5,5,39,0]

var still_wrong : bool = false:
	set(value):
		if value :
			var num = randi() % 3
			quiz_audio.stop()
			quiz_idle.stop()
			TA_Audio.stream = load("res://asset/Garnish/Sound/correct & wrong/w" + str(num) + ".ogg")
			TA_Audio.play()
			Project_Icon.visible = false
			Quiz_Node.visible = false
			Try_Again.visible = true
			Try_Again.play()
			countdown_time = 0
			Timer_Count.stop()
		else :
			TA_Audio.stop()
			Try_Again.stop()
			quiz_idle.play()
			Project_Icon.visible = true
			Quiz_Node.visible = true
			Try_Again.visible = false
			time_setup()
		still_wrong = value
	get:
		return still_wrong

var still_correct : bool = false:
	set(value):
		if value :
			var num = randi() % 3
			quiz_audio.stop()
			quiz_idle.stop()
			GJ_Audio.stream = load("res://asset/Garnish/Sound/correct & wrong/c" + str(num) + ".ogg")
			GJ_Audio.play()
			Good_Job.play()
			Project_Icon.visible = false
			Quiz_Node.visible = false
			Good_Job.visible = true
		else :
			GJ_Audio.stop()
			quiz_idle.play()
			Good_Job.stop()
			Project_Icon.visible = true
			Quiz_Node.visible = true
			Good_Job.visible = false
		still_correct = value
	get:
		return still_correct
	
func _ready() -> void:
	if json_path == null :
		source = ScenesManager.data.data
		situation = ScenesManager.situation
	else :
		source = json_path.data
		situation = 1
	max_score = int(source.map(func(section): return section.num).max())
	point =  1
	score = 0
	wrong_count = 0
	
	setup()
	Scenario_Node.visible = true
	END_Node.visible = false
	generate_quiz()

func time_setup():
	countdown_time = 3000
	pos_x_father = -46
	Father.position = Vector2(pos_x_father,-144)
	Timer_Count.start()

func setup():
	Try_Again.visible = false
	Good_Job.visible = false
	
	Answer_Node.visible = false
	Replay_Answer.visible = false
	Next_Answer.visible = false
	
	Quiz_Node.visible = false
	Quiz_img.visible = false
	
	Scenario_Node.visible = false

func _on_scenario_audio_finished() -> void:
	check_timer.stop()
	
	Scenario_Video.stop()
	scenario_audio.stop()
	scenario_idle.stop()
	
	Scenario_Node.visible = false
	
	Quiz_Node.visible = true
	quiz_idle.play()
	quiz_audio.play()
	time_setup()
	
func generate_quiz() :
	Answer_Video.paused = false
	Scenario_Video.paused = false
	Answer_Node.visible = false
	p = json_path.data[point-1]
	
	answer_description = p.correct_desc.replace("$", "")
	
	if p.has_scenario :
		Scenario_Node.visible = true
		var Scenario_video_path = "res://asset/Situation_" + str(situation) + "/Video/Scenario/Scenario" + str(point) + ".ogv"
		var Scenario_audio_path = "res://asset/Situation_" + str(situation) + "/Sound/Point/SN (" + str(point) + ").ogg"
		Scenario_Video.stream = load(Scenario_video_path)
		Scenario_Video.play()
		check_timer.start()
		scenario_audio.stream = load(Scenario_audio_path)
		scenario_audio.play()
		scenario_idle.play()
		Scenario_Index.text = "#" + str(point)
		is_have_Scenario = true
	else :
		Scenario_Node.visible = false
		Quiz_Node.visible = true
		quiz_idle.play()
		is_have_Scenario = false
		time_setup()

	var quiz_audio_path = "res://asset/Situation_" + str(situation) + "/Sound/QS (" + str(point) + ").ogg"
	quiz_audio.stream = load(quiz_audio_path)
	
	var answer_audio_path = "res://asset/Situation_" + str(situation) + "/Sound/AS (" + str(point) + ").ogg"
	answer_audio.stream = load(answer_audio_path)
	
	Index_question.text = "#" + str(point)
	
	var q = str(int(p.num)) + ". " + p.Question 
	Question.bbcode_text = q
	
	if is_have_Scenario == false :
		quiz_audio.play()
	Random_choice()
	Display_Choice(wrong_count)

func Random_choice():
	p.Options.shuffle()

func Display_Choice(num):
	for i in range(4) :
		var select = p.Options[num][i]
		if select.ends_with(".png"):
			choiceAC.add_theme_constant_override("separation", 25)
			choiceBD.add_theme_constant_override("separation", 25)
			all_question.add_theme_constant_override("separation", 40)
			var real_select = select
			match i:
				0:
					Button_A.icon = load(real_select)
					Button_A.text = ""
				1:
					Button_B.icon = load(real_select)
					Button_B.text = ""
				2:
					Button_C.icon = load(real_select)
					Button_C.text = ""
				3:
					Button_D.icon = load(real_select)
					Button_D.text = ""
		else :
			choiceAC.add_theme_constant_override("separation", 80)
			choiceBD.add_theme_constant_override("separation", 80)
			all_question.add_theme_constant_override("separation", 80)
			match i:
				0:
					Button_A.text = select
					Button_A.icon = null
					
					if p.has_quiz_img :
						ButtonA_Extra.text = select
						ButtonA_Extra.icon = null
				1:
					Button_B.text = select
					Button_B.icon = null
					
					if p.has_quiz_img :
						ButtonB_Extra.text = select
						ButtonB_Extra.icon = null
				2:
					Button_C.text = select
					Button_C.icon = null
					
					if p.has_quiz_img :
						ButtonC_Extra.text = select
						ButtonC_Extra.icon = null
				3:
					Button_D.text = select
					Button_D.icon = null
					
					if p.has_quiz_img :
						ButtonD_Extra.text = select
						ButtonD_Extra.icon = null

	if p.has_quiz_img :
		Quiz_img.visible = true
		HBox.visible = false
		VBox_Extra.visible = true
		Quiz_img.texture = load("res://asset/Situation_" + str(situation) + "/Picture/Question" + str(point) +".png")
	else :
		Quiz_img.visible = false
		HBox.visible = true
		VBox_Extra.visible = false
		Quiz_img.texture = null

func judge():
	var select = p.Options[wrong_count][select_button]
	var real_select = select
	if real_select == p.correct :
		if !wrong :
			score += 1
		still_correct = true
		await get_tree().create_timer(2.8).timeout
		still_correct = false
		
		setup()
		Scenario_Block.visible = false
		correcty()
		Scenario_Block.visible = true
		#point += 1
		wrong_count = 0
		wrong = false
	else :
		wrong_step()

func wrong_step():
	wrong = true
	wrong_count += 1
	still_wrong = true
	await get_tree().create_timer(2.8).timeout
	still_wrong = false
	if wrong_count > 3:
		setup()
		Scenario_Block.visible = false
		correcty()
		Scenario_Block.visible = true
		wrong_count = 0
		wrong = false
	else :
		Display_Choice(wrong_count)
			
func nurse_calling():
	Nurse.visible = true
	var number = int(p.nurse_fomat)
	match number:
		0:
			Nurse.visible = false
		1:
			Nurse.visible = true
			Nurse.texture = load("res://asset/Garnish/Nurse/nurse_double_point.png")
			Nurse.flip_h = true
			Nurse.size = Vector2(616,312)
			Nurse.position = Vector2(1416,600)
		2:
			Nurse.visible = true
			Nurse.texture = load("res://asset/Garnish/Nurse/nurse_thump_up.png")
			Nurse.flip_h = false
			Nurse.size = Vector2(688,360)
			Nurse.position = Vector2(-176,472)
		3:
			Nurse.visible = true
			Nurse.texture = load("res://asset/Garnish/Nurse/nurse_point_down.png")
			Nurse.flip_h = false
			Nurse.size = Vector2(472,264)
			Nurse.position = Vector2(1480,650)
		4:
			Nurse.visible = true
			Nurse.texture = load("res://asset/Garnish/Nurse/nurse_correct.png")
			Nurse.flip_h = false
			Nurse.size = Vector2(304,368)
			Nurse.position = Vector2(48,472)
		5:
			Nurse.visible = true
			Nurse.texture = load("res://asset/Garnish/Nurse/nurse_star.png")
			Nurse.flip_h = false
			Nurse.size = Vector2(280,368)
			Nurse.position = Vector2(1568,550)
		6:
			Nurse.visible = true
			Nurse.texture = load("res://asset/Garnish/Nurse/nurse_idea.png")
			Nurse.flip_h = false
			Nurse.size = Vector2(280,392)
			Nurse.position = Vector2(1568,550)

func correcty():
	Timer_Count.stop()
	quiz_idle.stop()
	scenario_audio.stop()
	Answer_Node.visible = true
	Quiz_img.visible = false
	var answer_path = "res://asset/Situation_" + str(situation)
	back.visible = false
	Answer_Desc.custom_minimum_size = Vector2(0,140)
	Answer_Texture.custom_minimum_size = Vector2(0,700)
	Answer_Video.custom_minimum_size = Vector2(0,700)
	Answer_Video.paused = false
	Scenario_Video.paused = false
	
	if p.has_answer_image and !p.has_answer_video:
		back.visible = true
		Extra_Panel.visible = false
		Answer_Texture.visible = true
		Answer_Video.visible = false
		Answer_Texture.texture = load(answer_path + "/Picture/Answer" + str(point) + ".png")
	elif p.has_answer_video and !p.has_answer_image:
		back.visible = false
		Extra_Panel.visible = false
		Answer_Texture.visible = false
		Answer_Video.visible = true
		Answer_Video.stream = load(answer_path + "/Video/Answer/Answer" + str(point) + ".ogv")
		Answer_Video.play()
		check_timer.start()
	elif p.has_answer_video && p.has_answer_image:
		back.visible = false
		Answer_Texture.visible = false
		Answer_Video.visible = true
		Extra_Panel.visible = true
		Answer_Video.stream = load(answer_path + "/Video/Answer/Answer" + str(point) + ".ogv")
		print(answer_path + "/Video/Answer/Answer" + str(point) + ".ogv")
		Answer_Video.play()
		check_timer.start()
	else :
		back.visible = false
		Answer_Video.visible = false
		Extra_Panel.visible = false
		
	answer_audio.play()
	answer_idle.play()
	nurse_calling()
	
	if p.correct.ends_with(".png") :
		Answer_Texture.visible = true
		Answer_Texture.texture = load(p.correct)
		Answer_Choice.text = ""
	else :
		Answer_Choice.text = p.correct

	Answer_Desc.text = ""
	Refer.text = p.refer
	
	if p.correct_desc == "" :
		await get_tree().create_timer(6).timeout
		Extra_Panel.visible = false
		Answer_Video.stop()
		answer_audio.stop()
		Answer_Choice.text = ""
		Answer_Desc.text = ""
		Answer_Texture.texture = null
		Next_Answer.visible = true
		Replay_Answer.visible = true
	else :
		show_next_word()
	back.visible = false
	Nurse.visible = false
		
func show_next_word():
	sign = false
	var text = p.correct_desc.split("$")
	var time_video = answer_audio.stream.get_length()
	var delay_time = ((time_video) / (p.correct_desc.count("$") + 1))
	for i in range(p.correct_desc.count("$") + 1) :
		if sign:
			return
		for j in text[i]: 
			if sign:
				return
			run_text += j
			Answer_Desc.text = run_text
			await get_tree().create_timer(0.03).timeout
			
		Answer_Desc.text = text[i]
		run_text = ""
		await get_tree().create_timer(delay_time - (text[i].length() * 0.03)).timeout
	sign = false
	
	run_text = ""
	Answer_Video.stop()
	answer_audio.stop()
	Answer_Choice.text = ""
	Answer_Desc.text = ""
	Answer_Texture.texture = null
	Next_Answer.visible = true
	Replay_Answer.visible = true

func _on_end_audio_finished() -> void:
	if point == 22 :
		point += 1
		end_idle.stop()
		answer_audio.stop()
		setup()
		END_Node.visible = true
		if score >= 16 :
			Ending.texture = load("res://asset/Garnish/Ending/best_ending.png")
			end_audio.stream = load("res://asset/Garnish/Sound/end/best_end.ogg")
			end_audio.play()
		elif score <= 10 :
			Ending.texture = load("res://asset/Garnish/Ending/bad_ending.png")
			end_audio.stream = load("res://asset/Garnish/Sound/end/bad_end.ogg")
			end_audio.play()
		else :
			Ending.texture = load("res://asset/Garnish/Ending/good_ending.png")
			end_audio.stream = load("res://asset/Garnish/Sound/end/good_end.ogg")
			end_audio.play()
			
		SCORE_END.text = str(score) + "/21"
	else :
		pass
		
func _on_next_button_down() -> void:
	run_text = ""
	sign = true
	point += 1
	check_timer.stop()
	Answer_Video.paused = false
	Scenario_Video.paused = false
	if point > 21 :
		Extra_Panel.visible = false
		Next_Answer.visible = false
		Replay_Answer.visible = false
		back.visible = false
		Answer_Node.visible = true
		Answer_Block.visible = true
		Answer_Texture.visible = false
		Answer_Video.visible = true
		Answer_Video.stream = load("res://asset/Situation_1/Video/Answer/Answer21_2.ogv")
		end_audio.stream = load("res://asset/Situation_1/Sound/AS (21_2).ogg")
		answer_idle.stop()
		end_idle.play()
		Answer_Video.play()
		end_audio.play()
	else :
		go_next()

func _on_replay_button_down() -> void:
	Answer_Video.paused = false
	Replay_Answer.visible = false
	Next_Answer.visible = false
	correcty()
	
func go_next():
	answer_idle.stop()
	Answer_Block.visible = true
	generate_quiz()
	
func _on_button_a_pressed() -> void:
	select_button = 0
	judge()

func _on_button_b_pressed() -> void:
	select_button = 1
	judge()

func _on_button_c_pressed() -> void:
	select_button = 2
	judge()

func _on_button_d_pressed() -> void:
	select_button = 3
	judge()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and END_Node.visible == true and is_pressed == false:
		is_pressed = true
		ScenesManager.clear_data_previous()
		get_tree().change_scene_to_file("res://scene/situation_select.tscn")

func _on_timer_timeout() -> void:
	countdown_time -= 1
	pos_x_father += 0.192
	Father.position = Vector2(pos_x_father,-144)
	if countdown_time == -1 :
		wrong_step()

func _on_skip_button_down() -> void:
	scenario_idle.stop()
	scenario_audio.stop()
	Scenario_Video.stop()
	quiz_audio.play()
	quiz_idle.play()
	
	Scenario_Node.visible = false
	
	Quiz_Node.visible = true
	time_setup()

func _on_answer_audio_finished() -> void:
	if point > 21 :
		Next_Answer.visible = true

func _on_skip_button_down_answer() -> void:
	sign = true
	run_text = ""
	point += 1
	check_timer.stop()
	Answer_Video.paused = false
	Scenario_Video.paused = false
	if point > 21 :
		Extra_Panel.visible = false
		Next_Answer.visible = false
		Replay_Answer.visible = false
		back.visible = false
		Answer_Node.visible = true
		Answer_Block.visible = true
		Answer_Texture.visible = false
		Answer_Video.visible = true
		Answer_Video.stream = load("res://asset/Situation_1/Video/Answer/Answer21_2.ogv")
		end_audio.stream = load("res://asset/Situation_1/Sound/AS (21_2).ogg")
		answer_idle.stop()
		end_idle.play()
		Answer_Video.play()
		end_audio.play()
	else :
		go_next()

func _on_timer_2_timeout() -> void:
	if Answer_Video.is_playing() and Answer_Video.stream_position >= ASS[point-1] - 0.05:
		Answer_Video.paused = true
	elif Scenario_Video.is_playing() and Scenario_Video.stream_position >= SNS[point-1] - 0.05:
		Scenario_Video.paused = true
