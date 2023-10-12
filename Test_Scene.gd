extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

# This is called if the "player has been hit" signal has been emitted.
func _on_player_hit():
	# Kill (delete) the player.
	$Player.queue_free()
