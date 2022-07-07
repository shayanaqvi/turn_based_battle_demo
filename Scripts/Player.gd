extends Node2D

onready var sharedStats = preload("res://Resources/SharedStats.tres")
onready var player1TurnCountLabel = $CanvasLayer/P1TurnCount
onready var playerNumberLabel = $CanvasLayer/PlayerLabel
onready var shade = $CanvasLayer/Shade
onready var skipTurnLabel = $CanvasLayer/SkipTurn
onready var spriteShade = $SpriteShade
onready var positionAtTurnStart = Vector2.ZERO
onready var player1TurnTimer = $Player1TurnTimer
onready var player1TurnTimerLabel = $CanvasLayer/TurnTimeLeft
onready var tween = $Tween

var maxMoves = 3
var moves = maxMoves
var allowTurnTimerToStart: bool = false
var timerTimeLeftInSeconds

var maxP1Health = 15
var p1Health = maxP1Health

func _ready():
	sharedStats.player2TurnStarted = false
	shade.visible = false
	skipTurnLabel.visible = false
	spriteShade.visible = false
	player1TurnTimer.wait_time = 4
	allowTurnTimerToStart = false

func _process(_delta):
	if moves > 0:
		player_1_movement()
	
	if moves == 0:
		yield(get_tree().create_timer(0.05), "timeout")
		sharedStats.player2TurnStarted = true #i.e. player 2 turn started
		replenish_player_2_moves() #resets player 2's moves 
	
	if Input.is_action_just_pressed("p1_skip_turn"):
		moves = 0
	
	if sharedStats.player2TurnStarted == false: #i.e. p1's turn
		shade.visible = false
		spriteShade.visible = false
		player1TurnCountLabel.text = str(moves) + " moves left"
		skipTurnLabel.visible = true
		if moves == 1:
			player1TurnCountLabel.text = str(moves) + " move left"
	else:
		player1TurnTimer.stop()
		allowTurnTimerToStart = false
		player1TurnTimerLabel.hide()
		shade.visible = true
		spriteShade.visible = true
		player1TurnCountLabel.text = "Waiting for turn"
		shade.text = player1TurnCountLabel.text
		skipTurnLabel.visible = false
	
	player1TurnTimerLabel.text = str(player1TurnTimer.time_left).pad_decimals(1)

	#Battle System Code

	if sharedStats.p2AttackPressed == true:
		p1Health -= sharedStats.p2AttackStrength
		print(p1Health)
		sharedStats.p2AttackPressed = false

func player_1_movement():
	if sharedStats.player2TurnStarted == false:	

		if allowTurnTimerToStart == false:
			player1TurnTimerLabel.show()
			player1TurnTimer.start()
			allowTurnTimerToStart = true
		
		if moves > 0:			
			if Input.is_action_just_pressed("p1_move_forward"):
				position.y -= 16
				yield(get_tree().create_timer(0.05), "timeout")
				moves -= 1
			if Input.is_action_just_pressed("p1_move_backward"):
				position.y += 16
				yield(get_tree().create_timer(0.05), "timeout")
				moves -= 1
			if Input.is_action_just_pressed("p1_move_left"):
				position.x -= 16
				yield(get_tree().create_timer(0.05), "timeout")
				moves -= 1
			if Input.is_action_just_pressed("p1_move_right"):
				position.x += 16
				yield(get_tree().create_timer(0.05), "timeout")
				moves -= 1
		
		if position.x < 96:
			position.x = 104
			moves += 1
		elif position.y > 144:
			position.y = 136
			moves += 1
		elif position.y < 0:
			position.y = 8
			moves += 1
		elif position.x > 256:
			position.x = 248
			moves += 1
			

func replenish_player_2_moves():
	moves = maxMoves

func _on_Player1TurnTimer_timeout():
	allowTurnTimerToStart = false
	moves = 0
