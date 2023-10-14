extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when the player enters Door1.
func _on_room_1_door_1_entered():
	# Deactivate the current room.
	$Room1.hide()
	$Room1.set_deferred("disabled", true)
	# Bring in the new room.
	var scene = load("res://room_2.tscn")
	var instance = scene.instantiate()
	add_child(instance)
	move_child(instance, 0)
	
	
	# Move the player to the appropriate location.
	$Player.position = Vector2(1152/2, 648 - 150)
	
