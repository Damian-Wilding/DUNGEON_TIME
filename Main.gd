extends Node

var view


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Move the player to the bottom of the screen.
func _move_player_to_bottom():
	$Player.position = Vector2(1152/2, 648 - 150)
# Move the player to the top of the screen.
func _move_player_to_top():
	$Player.position = Vector2(1152/2, 150)
# Move the player to the left side of the screen.
func _move_player_to_left():
	$Player.position = Vector2(150, 648/2)
# Move the player to the right side of the screen.	
func _move_player_to_right():
	$Player.position = Vector2(1152 - 150, 648/2)
	
	
# Move the player through a door on the top side of the room.
func _move_player_through_upper_door():
	$Player.position.y -= 200
# Move the player through a door on the bottom side of the room.
func _move_player_through_lower_door():
	$Player.position.y += 200
# Move the player through a door on the right side of the room.
func _move_player_through_right_door():
	$Player.position.x += 400
# Move the player through a door on the left side of the room.
func _move_player_through_left_door():
	$Player.position.x -= 400
	
	
# Move the camera up by one screen length.
func _move_camera_up():
	$Camera2D.position.y -= 648
# Move the camera down by one screen length.
func _move_camera_down():
	$Camera2D.position.y += 648
# Move the camera left by one screen length.
func _move_camera_left():
	$Camera2D.position.x -= 1152
# Move the camera right by one screen length.
func _move_camera_right():
	$Camera2D.position.x += 1152
	
	
# This function is called to deactivate a room.
func _deactivate_room(room):
	# Deactivate room.
	room.hide()
	room.set_deferred("disabled", true)
	
	
# This function is called to activate a room.
func _activate_room(room):
	# Activate room.
	room.show()
	room.set_deferred("disabled", false)


# This is called when the player enters Door1.
func _on_room_1_door_1_entered():
	print("Entering Door1")
	# Reactivate Room2.
	_activate_room($Room2)
	# Deactivate Room1.
	_deactivate_room($Room1)
	# Move the Player and Camera to be in Room2.
	_move_camera_up()
	_move_player_through_upper_door()
	

# This is called when the player enters Door2.
func _on_room_2_door_2_entered():
	print("Entering Door2")
	# Reactivate Room2.
	_activate_room($Room1)
	# Deactivate Room1.
	_deactivate_room($Room2)
	# Move the Player and Camera to be in Room2.
	_move_camera_down()
	_move_player_through_lower_door()


# This is called when the player enters Door3.
func _on_room_2_door_3_entered():
	print("Entering Door3")
	# Reactivate Room2.
	_activate_room($Room3)
	# Deactivate Room1.
	_deactivate_room($Room2)
	# Move the Player and Camera to be in Room2.
	_move_camera_up()
	_move_player_through_upper_door()


# This is called when the player enters Door4.
func _on_room_3_door_4_entered():
	print("Entering Door4")
	# Reactivate Room2.
	_activate_room($Room2)
	# Deactivate Room3.
	_deactivate_room($Room3)
	# Move the Player and Camera to be in Room2.
	_move_camera_down()
	_move_player_through_lower_door()


# This is called when the player enters Door5.
func _on_room_3_door_5_entered():
	print("Entering Door5")
	# Reactivate Room4.
	_activate_room($Room4)
	# Deactivate Room3.
	_deactivate_room($Room3)
	# Move the Player and Camera to be in Room4.
	_move_camera_up()
	_move_player_through_upper_door()


# This is called when the player enters Door6.
func _on_room_4_door_6_entered():
	print("Entering Door6")
	# Reactivate Room3.
	_activate_room($Room3)
	# Deactivate Room4.
	_deactivate_room($Room4)
	# Move the Player and Camera to be in Room3.
	_move_camera_down()
	_move_player_through_lower_door()


# This is called when the player enters Door7.
func _on_room_4_door_7_entered():
	print("Entering Door7")
	# Reactivate Room5.
	_activate_room($Room5)
	# Deactivate Room4.
	_deactivate_room($Room4)
	# Move the Player and Camera to be in Room5.
	_move_camera_left()
	_move_player_through_left_door()


# This is called when the player enters Door8.
func _on_room_4_door_8_entered():
	print("Entering Door8")
	# Reactivate Room7.
	_activate_room($Room7)
	# Deactivate Room4.
	_deactivate_room($Room4)
	# Move the Player and Camera to be in Room7.
	_move_camera_up()
	_move_player_through_upper_door()


# This is called when the player enters Door9.
func _on_room_4_door_9_entered():
	print("Entering Door9")
	# Reactivate Room6.
	_activate_room($Room6)
	# Deactivate Room4.
	_deactivate_room($Room4)
	# Move the Player and Camera to be in Room6.
	_move_camera_right()
	_move_player_through_right_door()


# This is called when the player enters Door10.
func _on_room_5_door_10_entered():
	print("Entering Door10")
	# Reactivate Room4.
	_activate_room($Room4)
	# Deactivate Room5.
	_deactivate_room($Room5)
	# Move the Player and Camera to be in Room4.
	_move_camera_right()
	_move_player_through_right_door()


# This is called when the player enters Door11.
func _on_room_6_door_11_entered():
	print("Entering Door11")
	# Reactivate Room4.
	_activate_room($Room4)
	# Deactivate Room6.
	_deactivate_room($Room6)
	# Move the Player and Camera to be in Room4.
	_move_camera_left()
	_move_player_through_left_door()


# This is called when the player enters Door12.
func _on_room_7_door_12_entered():
	print("Entering Door12")
	# Reactivate Room4.
	_activate_room($Room4)
	# Deactivate Room7.
	_deactivate_room($Room7)
	# Move the Player and Camera to be in Room4.
	_move_camera_down()
	_move_player_through_lower_door()
