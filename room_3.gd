extends Area2D

signal door4_entered
signal door5_entered


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start with the room hidden and disabled.
	hide()
	set_deferred("disabled", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when a body hitbox enters the Door5 hitbox.
func _on_door_5_body_entered(body):
	# This checks that the hitbox entering the Door5 hitbox is the player's hitbox.
	if body.name == "Player":
		# Signal that the player has entered Door5.
		door5_entered.emit()
		

# This is called when a body hitbox enters the Door4 hitbox.
func _on_door_4_body_entered(body):
	# This checks that the hitbox entering the Door4 hitbox is the player's hitbox.
	if body.name == "Player":
		# Signal that the player has entered Door4.
		door4_entered.emit()
