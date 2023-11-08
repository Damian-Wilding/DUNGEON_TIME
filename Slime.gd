extends CharacterBody2D

var speed = 100
@export var random_direction = randi_range(0, 4)
@export var seconds_to_idle = 1
@export var seconds_to_move = 1
@export var is_idle = false
@export var can_leave_room = false
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


# Called when the node enters the scene tree for the first time.
func _ready():
	# Start the enemy's idle timer.
	$IdleTimer.start()
	# Play the enemies idle animation.
	$AnimatedSprite2D.play("idle")
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
		
		
		# Updates the position of the enemy.
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
	# Play the idle animation.
	$AnimatedSprite2D.play("idle")


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
