extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when a body hitbox enters the key's hitbox.
func _on_body_entered(body):
	# Check to see if the hitbox belongs to the player.
	if body.name == "Player":
		# Delete the key off the ground.
		queue_free()
		# Give the player a key.
		get_parent().get_parent().get_node("Player").keys += 1
		
