extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when a body hitbox enters the stair's hitbox.
func _on_body_entered(body):
	# Check to see if the body is the player's body.
	if body.name == "Player":
		# Move the player and camera back to the starting position.
		get_parent().get_parent().find_child("Player").position = Vector2(1152/2, 648/2)
		get_parent().get_parent().find_child("Camera2D").position = Vector2(1152/2, 648/2)
		# Delete the current floor.
		if get_parent().get_parent().has_node("FirstFloor") == true:
			# Delete the the first floor if the player exits it.
			get_parent().get_parent().find_child("FirstFloor").queue_free()
		if get_parent().get_parent().has_node("Floor") == true:
			# Delete floors after floor 1.
			get_parent().get_parent().find_child("Floor").queue_free()
		

