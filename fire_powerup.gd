extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Called when a body hitbox enters the fire powerup's hitbox.
func _on_body_entered(body): 
	# This makes sure the hitbox is the player's hitbox.
	if body.name == "Player":
		# Give the player the powerup.
		body.has_fireball_powerup = true
		# Make fireball powerup disappear.
		queue_free()
		
