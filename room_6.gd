extends Area2D

signal door11_entered


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start with the room hidden and disabled.
	hide()
	set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when a body hitbox enters the Door11 hitbox.
func _on_door_11_body_entered(body):
	# This checks that the hitbox entering the Door11 hitbox is the player's hitbox.
	if body.name == "Player":
		# Signal that the player has entered Door11.
		door11_entered.emit()

