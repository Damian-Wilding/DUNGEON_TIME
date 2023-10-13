extends Node

var player_hitbox
signal door1_entered


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when a hitbox enters the Door1 hitbox.
func _on_door_1_parent_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	# This checks that the hitbox entering the Door1 hitbox is the player's hitbox.
	if area.name == "Player":
		# Signal that the player has entered Door1.
		door1_entered.emit()
		
