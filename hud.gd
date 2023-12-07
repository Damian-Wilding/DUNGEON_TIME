extends Control

var hp


# Called when the node enters the scene tree for the first time.
func _ready():
	# Give the player 5 hearts when the HUD is created.
	$HealthBar/AnimatedSprite2D.play("5 hearts")
	
	
	$DeleteThisLater.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when the player takes damage.
func _lose_a_heart():
	hp = %Player.hp
	print("HUD notices that player takes damage")
	print("%s hearts" % hp)
	$HealthBar/AnimatedSprite2D.play("%s hearts" % hp)
