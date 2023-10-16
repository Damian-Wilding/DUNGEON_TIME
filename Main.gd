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






# This is called when the player enters Door1.
func _on_room_1_door_1_entered():
	# Reactivate Room2.
	$Room2.show()
	$Room2.set_deferred("disabled", false)
	move_child($Room2, 0)
	# Deactivate Room1.
	$Room1.hide()
	$Room1.set_deferred("disabled", true)
	# Move the Player and Camera to be in Room2.
	_move_camera_up()
	$Camera2D.zoom.x -= .75
	$Camera2D.zoom.y -= .75
	$Player._change_player_area()
	_move_player_to_bottom()
	#$Player.position = $Room2/Marker2D.position
	#move_child($Player, 10)
