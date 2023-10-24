extends Area2D

signal door6_entered
signal door7_entered
signal door8_entered
signal door9_entered


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start with the room hidden and disabled.
	hide()
	set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when a body hitbox enters the unlock area. 
func _on_unlock_area_body_entered(body):
	# Check to see if the body is the player's and that the player has a key.
	if body.name == "Player" and body.keys >= 1:
		# Take away one of the player's keys.
		body.keys -= 1
		# Remove the lock.
		get_node("Lock").queue_free()
		# Remove the unlock area since it is no longer needed.
		get_parent().remove_child($UnlockArea)


# This is called when a body hitbox enters the Door6 hitbox.
func _on_door_6_body_entered(body):
	# This checks that the hitbox entering the Door6 hitbox is the player's hitbox.
	if body.name == "Player":
		# Signal that the player has entered Door6.
		door6_entered.emit()


# This is called when a body hitbox enters the Door7 hitbox.
func _on_door_7_body_entered(body):
	# This checks that the hitbox entering the Door7 hitbox is the player's hitbox.
	if body.name == "Player":
		# Signal that the player has entered Door7.
		door7_entered.emit()


# This is called when a body hitbox enters the Door8 hitbox.
func _on_door_8_body_entered(body):
	# This checks that the hitbox entering the Door8 hitbox is the player's hitbox.
	if body.name == "Player":
		# Signal that the player has entered Door8.
		door8_entered.emit()


# This is called when a body hitbox enters the Door9 hitbox.
func _on_door_9_body_entered(body):
	# This checks that the hitbox entering the Door9 hitbox is the player's hitbox.
	if body.name == "Player":
		# Signal that the player has entered Door9.
		door9_entered.emit()
