extends Control

var intro_finished = false
var selected = false
var select_id = 0
var select_button = ["res://levels/normal.tscn", "res://levels/difficult.tscn"]

func _on_animation_animation_finished(anim_name):
	$capcom_intro.queue_free()
	$bg.queue_free()
	$story.queue_free()
	$intro.queue_free()
	$Popup.popup()
	$music.play()
	intro_finished = true

func _process(delta):
	if intro_finished and !selected:
		if Input.is_action_just_pressed("ui_up"):
			select_id -= 1
		elif Input.is_action_just_pressed("ui_down"):
			select_id += 1
		select_id = clamp(select_id, 0, 1)
		
		if Input.is_action_just_pressed("ui_accept"):
			$Popup/select/audio.play()
			selected = true
			yield($Popup/select/audio,"finished")
			get_tree().change_scene(select_button[select_id])
		
		match select_id:
			0:
				$Popup/select.global_position = Vector2(56, 135)
			1:
				$Popup/select.global_position = Vector2(56, 152)