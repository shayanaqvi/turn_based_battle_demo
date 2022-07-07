extends Resource
class_name SharedStats

var player2TurnStarted: bool
var addExtraPlayer1MoveViaPowerup: bool = false
var addExtraPlayer2MoveViaPowerup: bool = false

var maxP1AttackStrength = 3
var p1AttackStrength = maxP1AttackStrength
var p1AttackPressed: bool

var maxP2AttackStrength = 3
var p2AttackStrength = maxP2AttackStrength
var p2AttackPressed: bool

var p1HealthRecovery = 2
var p1HealPressed: bool

var p2HealthRecovery = 2
var p2HealPressed: bool

var p1Pass: bool

var p2Pass: bool

var subtractP1Moves: bool

var subtractP2Moves: bool