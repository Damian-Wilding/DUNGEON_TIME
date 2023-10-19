extends CharacterBody2D

signal hit
var speed = 500
var screen_size
var is_player_attacking = false
@export var has_fireball_powerup = false
var fireball = preload("res://fireball.tscn")


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
	
	
	# Check to see if the player is attacking.
	if is_player_attacking == false:
		# Check to see if the player wants to attack.
		if Input.is_action_pressed("attack"):
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
			
	
	# Normalizes velocity (makes it so that diagonal movement isn't faster) and plays the sprite animation if the player is moving.
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
		
	# Updates the position of the player.
	move_and_collide(velocity * delta)


# This is called to use the fireball attack.
func _fireball_attack():
	var player_position = position
	var instance = fireball.instantiate()
	add_child(instance)
	instance.position = player_position


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
