extends Node2D

onready var sharedStats = preload("res://Resources/SharedStats.tres")


func _on_PassP2_pressed():
    sharedStats.p2Pass = true
    sharedStats.subtractP2Moves = true

func _on_HealP2_pressed():
    sharedStats.p2HealPressed = true
    sharedStats.subtractP2Moves = true

func _on_AttackP2_pressed():    
    sharedStats.p2AttackPressed = true
    sharedStats.subtractP2Moves = true

func _on_PassP1_pressed():
    sharedStats.p1Pass = true
    sharedStats.subtractP1Moves = true

func _on_HealP1_pressed():
    sharedStats.p1HealPressed = true
    sharedStats.subtractP1Moves = true

func _on_AttackP1_pressed():
    sharedStats.p1AttackPressed = true
    sharedStats.subtractP1Moves = true
