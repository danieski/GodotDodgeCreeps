extends CanvasLayer
var scoreHud=1
var scoreAux=0


# Notifies `Main` node that the button has been pressed
signal start_game

func show_message(text):
	
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game 0ver")
	await $MessageTimer.timeout
	$Message.text = "Shoot Asteroids"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$"GameTimerLabel".hide()
	
func update_score(score):
	scoreHud = score
	$ScoreLabel.text = str(score)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$GameTimerLabel.text = "Time: " + str(int($"Game Timer".time_left))
	#$"Game Timer".start(5)
	


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()
	$ScoreLabel.show()
	$GameTimerLabel.show()
	
	#$GameTimerLabel.text = str($"Game Timer".time_left)
	#$GameTimerLabel.text = str(99)


func _on_message_timer_timeout() -> void:
	$Message.hide()






func _on_game_timer_timeout() -> void:
	show_game_over()


func _on_main_hit() -> void:
	scoreHud += 1
	scoreAux += 1
	$TimeAdded.hide()
	if scoreAux >= 3:
		$"Game Timer".start($"Game Timer".time_left+1)
		$TimeAdded.show()
		$TimeAdded.text = "+1"

		scoreAux = 0
		
	update_score(scoreHud) 
