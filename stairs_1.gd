extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This is called when a body hitbox enters the stair's hitbox.
func _on_body_entered(body):
	# Check to see if the hitbox belongs to the player.
	if body.name == "Player":
		# Delete all the rooms in the main scene
		get_parent().get_parent().remove_child($Room1)
		get_parent().get_parent().remove_child($Room2)
		get_parent().get_parent().remove_child($Room3)
		get_parent().get_parent().remove_child($Room4)
		get_parent().get_parent().remove_child($Room5)
		get_parent().get_parent().remove_child($Room6)
		get_parent().get_parent().remove_child($Room7)
