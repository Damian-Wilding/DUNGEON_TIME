extends Area2D

signal hit
var speed = 300
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # Set the players velocity to 0.
	
	
	# Changes the players rotation and velocity based on what inputs are being entered.
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		if rotation != 3 * PI/2:
			rotation = 3 * PI/2
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		if rotation != PI/2:
			rotation = PI/2
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		if rotation != PI:
			rotation = PI
	if  Input.is_action_pressed("move_up"):
		velocity.y -= 1
		if rotation != 0:
			rotation = 0
		
		
	# Normalizes velocity (makes it so that diagonal movement isn't faster) and plays the sprite animation if the player is moving.
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
		
	# Updates the position of the player.
	position += velocity * delta 
	
	
	# Sets a clamp on the players position so that they can't go off screen.
	position = position.clamp(Vector2.ZERO, screen_size)


# This is called when another hitbox enters the player's hitbox.
func _on_body_entered(body):
	# Send out the "player has been hit" signal.
	hit.emit()
	# Kill (delete) the body that entered the player hitbox.
	body.queue_free()


# This is called when a hitbox enters the attack hitbox.



func _on_hitbox_parent_body_entered(body):
	body.queue_free()
