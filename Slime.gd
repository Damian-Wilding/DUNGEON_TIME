extends CharacterBody2D

var speed = 100
@export var random_direction = randi_range(0, 4)
@export var seconds_to_idle = 1
@export var seconds_to_move = 1
@export var is_idle = false
var is_white = false
@export var hp = 3
@export var can_leave_room = false
@export var is_taking_damage_recoil = false
@export var max_x = 0
@export var max_y = 0
@export var min_x = 0
@export var min_y = 0
var x_position
var y_position
var x_max
var x_min
var y_max
var y_min
var invincible = false


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start the enemy's idle timer.
	$IdleTimer.start()

	# Play the enemies idle animation.
	$AnimatedSprite2D.play("idle")
	# Set the enemy's hp.
	hp = 3
	# Set the enemy's boundaries if they have them.
	if can_leave_room == false:
		x_position = get_position().x
		y_position = get_position().y
		# Set the border for the enemy. (This makes it so they don't go through doors or on the top wall.)
		if  x_position > 0:
			x_max = (x_position + (1152 - (fmod(x_position, 1152)))) - 150
			x_min = (x_position - fmod(x_position, 1152)) + 116
		else:
			x_max = (x_position - fmod(x_position, -1152)) - 150
			x_min = ((x_position - ((fmod(x_position, -1152)))) - 1152) + 116
		if y_position > 0:
			y_max = (y_position + (648 - (fmod(y_position, 648)))) - 100
			y_min = (y_position - fmod(y_position, 648)) + 69
		else:
			y_max = (y_position - fmod(y_position, -648)) - 100
			y_min = ((y_position - ((fmod(y_position, -648)))) - 648) + 69


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# First check to see if the enemy is taking damage recoil. That will override any movement.
	if is_taking_damage_recoil == true:
		# Set the velocity for the enemy.
		velocity = (position - %Player.position).normalized() * 5
	else:
		# Sets the velocity to be zero from the last time.
		velocity = Vector2.ZERO
		# Check to see if the enemy is idle. If it's not then he should be moving.
		if is_idle == false:
			# Check what direction the enemy is going to go and make it go that direction.
			# Also check to make sure the enemy is in bounds. If it's out of bounds, it won't go in that direction anymore until it's back in bouds.
			if  random_direction == 1 and get_position().y > y_min:
				$AnimatedSprite2D.play("up")
				velocity = Vector2(0, -1)
			if  random_direction == 2 and get_position().x > x_min:
				velocity = Vector2(-1, 0)
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("left")
			if  random_direction == 3 and get_position().x < x_max:
				velocity = Vector2(1, 0)
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("left")
			if  random_direction == 4 and get_position().y < y_max:
				velocity = Vector2(0, 1)
				$AnimatedSprite2D.play("down")


	# Update the position of the enemy.
	_move(delta)


# This is called when the enemy's velocity needs to be used to update the enemy's position.
func _move(delta):
	# Check that the enemy isn't going through a wall. If they are, set the velocity in that direction to be 0.
	if position.x >= x_max and velocity.x > 0:
		print("Slime is out of bounds (Right)")
		velocity.x = 0
	elif position.x <= x_min and velocity.x < 0:
		print("Slime is out of bounds (Left)")
		velocity.x = 0
	if position.y >= y_max and velocity.y > 0:
		print("Slime is out of bounds (Down)")
		velocity.y = 0
	elif position.y <= y_min and velocity.y < 0:
		print("Slime is out of bounds (Up)")
		velocity.y = 0
	# Multiply the velocity by the enemy's speed stat.
	velocity = velocity * speed
	# Call the move and collide function to make the enemy move.
	move_and_collide(velocity * delta)


# This is called when this enemy takes damage.
func _take_damage():
	print("Enemy is taking damage.")
	# Check and make sure the enemy isnt invincible. Nothing will happen if it is.
	if invincible == false:
		# Make the enemy invincible for a short time.
		invincible = true
		# Start the red flash damage taken timer. (Has the enemy flash red when they take damage.
		$RedFlashDamageTakenTimer.start()
		# Have the enemy flash red while they take damage.
		$AnimatedSprite2D.modulate = Color(1, 0, 0)
		# Set the value that tells us that the enemy is taking recoil from something to be true.
		is_taking_damage_recoil = true
		# Start the recoil timer.
		$RecoilTimer.start()
		# Check to see if this enemy has more than 1 hp.
		if hp > 1:
			# If so, then have this enemy take 1 damage.
			hp -= 1
		# If this enemy doesn't have more than 1 hp then kill (delete this enemy).
		else:
			queue_free()
			# Add to the counter of the number of enemies killed by the player.
			%Player.enemies_killed += 1


# This is called when the ememy's movement timer finishes.
func _on_moving_timer_timeout():
	# Set the enemy to be idle.
	is_idle = true
	# Get a random number to be the idle timer's time.
	seconds_to_idle = randi_range(0, 5)
	seconds_to_idle = 0.5
	# Set it to be the idle timer's time.
	$IdleTimer.wait_time = seconds_to_idle
	# Start the idle timer.
	$IdleTimer.start()
	# Play the idle animation.
	$AnimatedSprite2D.play("idle")


# This is called when the ememy's idle timer finishes.
func _on_idle_timer_timeout():
	# Set the enemy to not be idle.
	is_idle = false
	# Get a random direction for the ememy to move in.
	random_direction = randi_range(1, 4)
	# Get a random number to be the moving timer's time.
	seconds_to_move = randi_range(0, 5)
	# Set it to be the moving timer's time.
	$MovingTimer.wait_time = seconds_to_move
	# Start the moving timer.
	$MovingTimer.start()


# This is called when a body hitbox enters the enemy's hit box.
func _on_slime_hitbox_parent_body_entered(body):
	# Check to see if the body is the player's body. (If it's not, then we don't care.)
	if body.name == "Player":
		# Have the player take damage.
		%Player._take_damage()
		# Have this enemy take damage.
		_take_damage()


# This is called when an Area2D hitbox enters the enemy's hitbox
func _on_slime_hitbox_parent_area_entered(area):
	# Check to see if the Area2D is the player's AttackHitbox.
	if area.name == "AttackHitboxParent":
		# Have tis enemy take damage.
		_take_damage()


# This is called when the enemy's invincibility period is over. 
func _on_invincibility_timer_timeout():
	# Make the enemy no longer invincible.
	invincible = false
	# Stop the invincibility flash timer since it won't be needed anymore.
	$InvincibilityFlashTimer.stop()
	# Make sure that the enemy doesn't have a tint to the sprite.
	$AnimatedSprite2D.modulate = Color(1, 1, 1)


# This is called when the enemy needs to change invincibility frames. (It will go back and forth while the enemy is invincible.)
func _on_invincibility_flash_timer_timeout():
	# Check to see if the enemy is white.
	if is_white == true:
		# Make the enemy not white.
		is_white = false
		$AnimatedSprite2D.modulate = Color(1, 1, 1)
	# This will be called if the enemy is not white.
	else:
		# Make the enemy white.
		is_white = true
		$AnimatedSprite2D.modulate = Color(2, 2, 2)


# This is called when the enemy is ready to stop being red from taking damage.
func _on_red_flash_damage_taken_timer_timeout():
	# Make the enemy not red anymore.
	$AnimatedSprite2D.modulate = Color(1, 1, 1)
	# Start the invincibility timers.
	$InvincibilityTimer.start()
	$InvincibilityFlashTimer.start()


# This is called when the enemy needs to stop flying back from damage recoil.
func _on_recoil_timer_timeout():
	# Set the velocity to zero since the enemy needs to stop taking recoil.
	velocity = Vector2.ZERO
	# Set the is taking damage recoil value to false.
	is_taking_damage_recoil = false
