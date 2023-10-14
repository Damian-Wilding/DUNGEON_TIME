extends Node

signal door2_entered
signal door3_entered


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start with the room hidden and disabled.
	hide()
	set_deferred("disabled", true)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when a hitbox enters the Door2 hitbox.
func _on_door_2_parent_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	# This checks that the hitbox entering the Door2 hitbox is the player's hitbox.
	if area.name == "Player":
		# Signal that the player has entered Door2.
		door2_entered.emit()


# This is called when a hitbox enters the Door3 hitbox.
func _on_door_3_parent_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	# This checks that the hitbox entering the Door3 hitbox is the player's hitbox.
	if area.name == "Player":
		# Signal that the player has entered Door3.
		door3_entered.emit()
