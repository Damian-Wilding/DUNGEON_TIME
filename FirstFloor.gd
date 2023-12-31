extends Area2D

var are_stairs_hidden


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start the floor out with the stairs hidden and disabled.
	$Stairs.hide()
	$Stairs/CollisionShape2D.set_deferred("disabled", true)
	# Mark that the stairs are hidden and disabled when the floor first appears.
	are_stairs_hidden = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Check to see if the stairs are hidden
	if are_stairs_hidden == true:
		# If they are hidden, check to see if they are ready to appear. (They appear when the player has killed all enemies on the floor.)
		if %Player.enemies_killed == 4:
			# If the player has killed all the enemies, then show and enable the stairs.
			$Stairs.show()
			$Stairs/CollisionShape2D.set_deferred("disabled", false)
			# Get rid of the text that tells the player how to make the stairs appear.
			$StairsInstructions.hide()


# Move the player through a door on the top side of the room.
func _move_player_through_upper_door():
	get_parent().find_child("Player").position.y -= 210
# Move the player through a door on the bottom side of the room.
func _move_player_through_lower_door():
	get_parent().find_child("Player").position.y += 210
# Move the player through a door on the right side of the room.
func _move_player_through_right_door():
	get_parent().find_child("Player").position.x += 400
# Move the player through a door on the left side of the room.
func _move_player_through_left_door():
	get_parent().find_child("Player").position.x -= 400
	
	
# Move the camera up by one screen length.
func _move_camera_up():
	get_parent().find_child("Camera2D").position.y -= 648
# Move the camera down by one screen length.
func _move_camera_down():
	get_parent().find_child("Camera2D").position.y += 648
# Move the camera left by one screen length.
func _move_camera_left():
	get_parent().find_child("Camera2D").position.x -= 1152
# Move the camera right by one screen length.
func _move_camera_right():
	get_parent().find_child("Camera2D").position.x += 1152


# Move the HUD up by one screen length.
func _move_hud_up():
	%HUD.position.y -= 648
# Move the HUD down by one screen length.
func _move_hud_down():
	%HUD.position.y += 648
# Move the HUD left by one screen length.
func _move_hud_left():
	%HUD.position.x -= 1152
# Move the HUD right by one screen length.
func _move_hud_right():
	%HUD.position.x += 1152


# This is called when a body hitbox enters the upper door's hitbox.
func _on_upper_doors_body_entered(body):
	# Check to see it the hitbox belongs to the player.
	if body.name == "Player":
		# Move the player up 1 room.
		_move_player_through_upper_door()
		# Move the camera up 1 room.
		_move_camera_up()
		# Move the HUD up 1 room.
		_move_hud_up()
		

# This is called when a body hitbox enters the right door's hitbox.
func _on_right_doors_body_entered(body):
	# Check to see it the hitbox belongs to the player.
	if body.name == "Player":
		# Move the player right 1 room.
		_move_player_through_right_door()
		# Move the camera right 1 room.
		_move_camera_right()
		# Move the HUD right 1 room.
		_move_hud_right()


# This is called when a body hitbox enters the lower door's hitbox.
func _on_lower_doors_body_entered(body):
	# Check to see it the hitbox belongs to the player.
	if body.name == "Player":
		# Move the player down 1 room.
		_move_player_through_lower_door()
		# Move the camera down 1 room.
		_move_camera_down()
		# Move the HUD down 1 room.
		_move_hud_down()


# This is called when a body hitbox enters the left door's hitbox.
func _on_left_doors_body_entered(body):
	# Check to see it the hitbox belongs to the player.
	if body.name == "Player":
		# Move the player left 1 room.
		_move_player_through_left_door()
		# Move the camera left 1 room.
		_move_camera_left()
		# Move the HUD left 1 room.
		_move_hud_left()
