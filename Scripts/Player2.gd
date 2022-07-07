extends Node2D

onready var sharedStats = preload("res://Resources/SharedStats.tres")
onready var player2TurnCountLabel = $CanvasLayer/P2TurnCount
onready var playerNumberLabel = $CanvasLayer/PlayerLabel
onready var shade = $CanvasLayer/Shade
onready var skipTurnLabel = $CanvasLayer/SkipTurn
onready var spriteShade = $SpriteShade
onready var positionAtTurnStart = Vector2.ZERO
onready var player2TurnTimer = $Player2TurnTimer
onready var player2TurnTimerLabel = $CanvasLayer/TurnTimeLeft

var p2Maxp2Moves = 3
var p2Moves = p2Maxp2Moves
var allowTurnTimerToStart: bool = false #check if this is being used from player.gd
var timerTimeLeftInSeconds

func _ready():
	sharedStats.player2TurnStarted = false
	shade.visible = true
	player2TurnTimer.wait_time = 4
	allowTurnTimerToStart = false
	sharedStats.subtractP2Moves = false

func _process(_delta):

	if Input.is_action_just_pressed("p1_skip_turn"):
		p2Moves -= 0
	
	if p2Moves > 0:
		player_2_movement()
	
	if p2Moves == 0:
		yield(get_tree().create_timer(0.05), "timeout")
		sharedStats.player2TurnStarted = false #i.e. player 2 turn ended
		replenish_player_1_p2Moves() #rsesets player 1's p2Moves
	
	if Input.is_action_just_pressed("p2_skip_turn"):
		p2Moves = 0
	
	if sharedStats.player2TurnStarted == true: #i.e. p2's turn
		shade.visible = false
		spriteShade.visible = false
		player2TurnCountLabel.text = str(p2Moves) + " moves left"
		skipTurnLabel.visible = true
		if p2Moves == 1:
			player2TurnCountLabel.text = str(p2Moves) + " move left"
	else:
		player2TurnTimer.stop()
		allowTurnTimerToStart = false
		player2TurnTimerLabel.hide()
		shade.visible = true
		spriteShade.visible = true
		player2TurnCountLabel.text = "Waiting for turn"
		shade.text = player2TurnCountLabel.text
		skipTurnLabel.visible = false
	
	player2TurnTimerLabel.text = str(player2TurnTimer.time_left).pad_decimals(1)
	
	#Battle System Code

	if sharedStats.subtractP2Moves == true:
		p2Moves -= 1
		sharedStats.subtractP2Moves = false

func player_2_movement():
	if sharedStats.player2TurnStarted == true:
		
		if allowTurnTimerToStart == false:
			player2TurnTimerLabel.show()
			player2TurnTimer.start()
			allowTurnTimerToStart = true
		
		if p2Moves > 0:
			if Input.is_action_just_pressed("p2_move_forward"):
				position.y -= 16
				yield(get_tree().create_timer(0.05), "timeout")
				p2Moves -= 1
			if Input.is_action_just_pressed("p2_move_backward"):
				position.y += 16
				yield(get_tree().create_timer(0.05), "timeout")
				p2Moves -= 1
			if Input.is_action_just_pressed("p2_move_left"):
				position.x -= 16
				yield(get_tree().create_timer(0.05), "timeout")
				p2Moves -= 1
			if Input.is_action_just_pressed("p2_move_right"):
				position.x += 16
				yield(get_tree().create_timer(0.05), "timeout")
				p2Moves -= 1
				
		if position.x < 96:
			position.x = 104
			p2Moves += 1
		elif position.y > 144:
			position.y = 136
			p2Moves += 1
		elif position.y < 0:
			position.y = 8
			p2Moves += 1
		elif position.x > 256:
			position.x = 248
			p2Moves += 1

func replenish_player_1_p2Moves():
	p2Moves = p2Maxp2Moves


func _on_Player2TurnTimer_timeout():
	allowTurnTimerToStart = false
	p2Moves = 0
