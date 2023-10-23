extends Area2D

signal door10_entered


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start with the room hidden and disabled.
	hide()
	set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when a body hitbox enters the Door10 hitbox.
func _on_door_10_body_entered(body):
	# This checks that the hitbox entering the Door10 hitbox is the player's hitbox.
	if body.name == "Player":
		# Signal that the player has entered Door10.
		door10_entered.emit()
