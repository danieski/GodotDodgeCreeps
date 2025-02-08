extends CanvasLayer
var scoreHud=1
var coinsHud=0


# Notifies `Main` node that the button has been pressed
signal start_game
func _ready() -> void:
	GlobalSignal.coin_obtained.connect(update_coins)
	GlobalSignal.asteroid_destroyed.connect(update_score)	
func show_message(text):
	
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	#$"../GameOver".play()
	$"GameTimerLabel".hide()
	show_message("Game 0ver")
	await $MessageTimer.timeout
	$Message.text = "Shoot Asteroids"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$ScoreLabel.hide()
	
func update_score(score):
	scoreHud = score
	$"Game Timer".start($"Game Timer".time_left +  1)
	
func update_coins(coin):
	coinsHud += 1
	$ScoreLabel.text = str(coinsHud)

func _process(delta: float) -> void:
	
	$GameTimerLabel.text = "Time: " + str(int($"Game Timer".time_left))

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()
	$ScoreLabel.show()
	$GameTimerLabel.show()




func _on_message_timer_timeout() -> void:
	$Message.hide()


func _on_game_timer_timeout() -> void:
	show_game_over()


func _on_main_hit(test) -> void:
	scoreHud += test
	update_score(scoreHud) 
