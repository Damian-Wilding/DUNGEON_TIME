extends Area2D

var player_hitbox
signal door1_entered


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when a body hitbox enters the Door1 hitbox.
func _on_door_1_parent_body_entered(body):
	# This checks that the hitbox entering the Door1 hitbox is the player's hitbox.
	if body.name == "Player":
		# Signal the the player has entered Door1.
		door1_entered.emit()
