extends CharacterBody2D

signal hit
var speed = 500
var screen_size
var is_player_attacking = false
@export var has_fireball_powerup = false
var fireball = preload("res://fireball.tscn")

var is_player_facing_up = true
var is_player_facing_down = false
var is_player_facing_left = false
var is_player_facing_right = false


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	# Hide the player's attack hitbox.
	$AttackHitboxParent.hide()
	# Disable the player's attack hitbox.
	$AttackHitboxParent/AttackHitbox.set_deferred("disabled", true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # Set the players velocity to 0.
	
	
	# Changes the players rotation and velocity based on what inputs are being entered.
	if  Input.is_action_pressed("move_up"):
		velocity.y -= 1
		is_player_facing_up = true
		is_player_facing_down = false
		is_player_facing_left = false
		is_player_facing_right = false
		if rotation != 0:
			rotation = 0
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
		is_player_facing_down = true
		is_player_facing_up = false
		is_player_facing_left = false
		is_player_facing_right = false
		if rotation != PI:
			rotation = PI
	elif Input.is_action_pressed("move_right"):
		velocity.x += 1
		is_player_facing_right = true
		is_player_facing_down = false
		is_player_facing_left = false
		is_player_facing_up = false
		if rotation != PI/2:
			rotation = PI/2
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		is_player_facing_left = true
		is_player_facing_down = false
		is_player_facing_up = false
		is_player_facing_right = false
		if rotation != 3 * PI/2:
			rotation = 3 * PI/2
	
	
	# Check to see if the player is attacking.
	if is_player_attacking == false:
		# Check to see if the player wants to attack.
		if Input.is_action_pressed("attack"):
			# Check to see if player has any powerups.
			if has_fireball_powerup == true:
				# Do a fireball attack.
				_fireball_attack()
			# Do a normal attack if player has no powerups.
			else:
				_normal_attack()
			
	
	# Normalizes velocity (makes it so that diagonal movement isn't faster) and plays the sprite animation if the player is moving.
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
		
	# Updates the position of the player.
	move_and_collide(velocity * delta)


# This is called when the player does a normal attack.
func _normal_attack():
	# Show the attack hitbox
	$AttackHitboxParent.show()
	# Activate the attack hitbox.
	$AttackHitboxParent/AttackHitbox.set_deferred("disabled", false)
	# Start the AttackTimer.
	$AttackTimer.start()
	# Start the AttackCooldownTimer.
	$AttackCooldownTimer.start()
	# Set is_player_attacking to be true since the player is now attacking.
	is_player_attacking = true


# This is called to use the fireball attack.
func _fireball_attack():
	# Get the player's position.
	var player_position = get_parent().get_node("Player").position
	
	
	# Create the first fireball.
	var fireball_1 = fireball.instantiate()
	get_parent().add_child(fireball_1)
	# Place the fireball where the player is.
	fireball_1.position = player_position
	# Set the fireball's velocity.
	if is_player_facing_up == true:
		fireball_1.velocity = Vector2(0, -1)
	elif is_player_facing_down == true:
		fireball_1.velocity = Vector2(0, 1)
	elif is_player_facing_right == true:
		fireball_1.velocity = Vector2(1, 0)
	elif is_player_facing_left == true:
		fireball_1.velocity = Vector2(-1, 0)
	
	# Create the second fireball.
	var fireball_2 = fireball.instantiate()
	get_parent().add_child(fireball_2)
	# Place the fireball where the player is.
	fireball_2.position = player_position
	# Set the fireball's velocity.
	if is_player_facing_up == true:
		fireball_2.velocity = Vector2(-1, -1)
	elif is_player_facing_down == true:
		fireball_2.velocity = Vector2(-1, 1)
	elif is_player_facing_right == true:
		fireball_2.velocity = Vector2(1, -1)
	elif is_player_facing_left == true:
		fireball_2.velocity = Vector2(-1, 1)
	# Rotate the fireball.
	fireball_2.rotation += PI/6
	
	# Create the third fireball.
	var fireball_3 = fireball.instantiate()
	get_parent().add_child(fireball_3)
	# Place the fireball where the player is.
	fireball_3.position = player_position
	# Set the fireball's velocity.
	if is_player_facing_up == true:
		fireball_3.velocity = Vector2(0, -1)
	elif is_player_facing_down == true:
		fireball_3.velocity = Vector2(0, 1)
	elif is_player_facing_right == true:
		fireball_3.velocity = Vector2(1, 0)
	elif is_player_facing_left == true:
		fireball_3.velocity = Vector2(-1, 0)
	# Rotate the fireball.
	fireball_3.rotation -= PI/6
	
	
	# Start the AttackTimer.
	$AttackTimer.start()
	# Start the AttackCooldownTimer.
	$AttackCooldownTimer.start()
	# Set is_player_attacking to be true since the player is now attacking.
	is_player_attacking = true


# This is called when the player's attack timer runs out.
func _on_attack_timer_timeout():
	# Hide the attack hitbox since the players attack has ended.
	$AttackHitboxParent.hide()
	# Deactivate the attack hitbox since it's still active while hidden.
	$AttackHitboxParent/AttackHitbox.set_deferred("disabled", true)
	

# This is called when the player's attack cooldown has finished.
func _on_attack_cooldown_timer_timeout():
	# Tell the game that the player is no longer attacking.
	is_player_attacking = false
