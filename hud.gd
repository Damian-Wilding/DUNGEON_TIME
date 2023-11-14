extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start the player off with 5 hearts.
	$HealthBar/AnimatedSprite2D.play("5 hearts")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
