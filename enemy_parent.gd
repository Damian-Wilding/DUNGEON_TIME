extends CharacterBody2D

var speed = 100
@export var random_direction = randi_range(0, 4)
@export var seconds_to_idle = 1
@export var seconds_to_move = 1
@export var is_idle = false
@export var is_roaming = false


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start the enemy's idle timer.
	$IdleTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_roaming == true:
		velocity = Vector2.ZERO
		if is_idle == false:
	
			if  random_direction == 1:
				$AnimatedSprite2D.play("up")
				velocity = Vector2(0, -1)
			if  random_direction == 2:
				velocity = Vector2(-1, 0)
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("left")
			if  random_direction == 3:
				velocity = Vector2(1, 0)
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("left")
			if  random_direction == 4:
				velocity = Vector2(0, 1)
				$AnimatedSprite2D.play("down")
		
		
			velocity = velocity * speed
			move_and_collide(velocity * delta)
		

# This is called when the ememy's movement timer finishes.
func _on_moving_timer_timeout():
	# Set the enemy to be idle.
	is_idle = true
	# Get a random number to be the idle timer's time.
	seconds_to_idle = randi_range(0, 5)
	# Set it to be the idle timer's time.
	$IdleTimer.wait_time = seconds_to_idle
	# Start the idle timer.
	$IdleTimer.start()


# This is called when the ememy's idle timer finishes.
func _on_idle_timer_timeout():
	# Set the enemy to not be idle.
	is_idle = false
	# Get a random number to be the moving timer's time.
	seconds_to_move = randi_range(0, 5)
	# Get a random direction for the ememy to move in.
	random_direction = randi_range(1, 4)
	# Set it to be the moving timer's time.
	$MovingTimer.wait_time = seconds_to_move
	# Start the moving timer.
	$MovingTimer.start()


# This is called when a body hitbox enters the enemy's hit box.
func _on_slime_hitbox_parent_body_entered(body):
	# Check to see if the body is the player's body. (If it's not, then we don't care.)
	if body.name == "Player":
		# Delete the player.
		body.queue_free()
	# Delete this enemy.
	queue_free()


# This is called when an Area2D hitbox enters the enemy's hitbox
func _on_slime_hitbox_parent_area_entered(area):
	# Check to see if the Area2D is the player's AttackHitbox.
	if area.name == "AttackHitboxParent":
		# Delete this enemy.
		queue_free()
