extends CanvasLayer
var coinsHud=0
var heartContainers : int
func _ready() -> void:
	
	GlobalSignal.coin_obtained.connect(update_coins)
	GlobalSignal.asteroid_destroyed.connect(update_score)	
	GlobalSignal.game_on_hud.connect(hud_game_on)
	GlobalSignal.on_player_hit.connect(on_player_hit)
	hud_game_off()
	
func _process(delta: float) -> void:
	$GameTimerLabel.text = "Time: " + str(int($"Game Timer".time_left))

func hud_game_on():
	
	%StartButton.hide()
	%CoinsLabel.show()
	%GameTimerLabel.show()
	%coin.show()
	%Message.hide()
	%"Game Timer".start(20)
	$Node2D.show()
	heartContainers = 3
func hud_game_off():
	
	%StartButton.show()
	#show_message_game_over()
	%CoinsLabel.hide()
	%GameTimerLabel.hide()
	%coin.hide()
	GlobalSignal.game_off_hud.emit()
	coinsHud = 0
	%CoinsLabel.text = str("0")
	#$Hearts.hide()
	$Node2D.hide()
	$"../GameOver".play()
func update_score(score):
	$"Game Timer".start($"Game Timer".time_left +  score)
	
func update_coins(coin):
	coinsHud += 1
	%CoinsLabel.text = str(coinsHud)
func on_player_hit():
	heartContainers -= 1
	print(heartContainers)
	match heartContainers:
		2:
			$Node2D/HeartPixelArt64x64.hide()
		1:
			$Node2D/HeartPixelArt64x65.hide()
		0:
			hud_game_off()
			$Node2D/HeartPixelArt64x64.show()
			$Node2D/HeartPixelArt64x65.show()
			$Node2D/HeartPixelArt64x66.show()
		_:
			$Node2D.hide()
func _on_start_button_pressed() -> void:
	GlobalSignal.game_on_hud.emit()
	hud_game_on()
	
func _on_game_timer_timeout() -> void:
	hud_game_off()
