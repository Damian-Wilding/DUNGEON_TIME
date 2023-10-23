extends Area2D

@export var velocity = Vector2.ZERO
var speed = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Move the fireball.
	position += speed * velocity * delta
	

# This is called when the fireball exits the screen.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


# This is called when a hitbox enters the fireball's hitbox.
func _on_area_entered(area):
	# Check to see if the hitbox is an enemy.
	# Check to see if the first 5 letters of the area's name is "Enemy"
	if area.name.left(5) == "Enemy":
		# Delete the enemy.
		area.queue_free()
		# Delete the fireball.
		queue_free()
