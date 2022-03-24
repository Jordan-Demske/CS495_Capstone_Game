extends CanvasLayer

signal start_game


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	# Wait untill the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	$Message.text = "USE AS DIRECTED"
	$Message.show()
	# Make a one-shot timer and wait for it to finish
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	$Directions.show()


func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	$Directions.hide()
	emit_signal("start_game")


func set_to_position(mod):
	var amount = $StatusBar.rect_size.x/10
	$StatusBar/Marker.rect_position.x = amount*mod - $StatusBar/Marker.rect_size.x/2


func move_marker(mod):
	var amount = $StatusBar.rect_size.x/10
	$StatusBar/Marker.rect_position.x += amount*mod



func _on_Directions_pressed():
	$Bottle.show()


func _on_Back_pressed():
	$Bottle.hide()
