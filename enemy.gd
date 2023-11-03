extends Area2D

@export var velocity = Vector2(25, 0)
 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position += velocity * delta
	pass


func _start(pos):
	position = pos


# This is called when a body hitbox enters the enemy's hit box.
func _on_body_entered(body):
	# Check to see if the body is the player's body. (If it's not, then we don't care.)
	if body.name == "Player":
		# Delete the player.
		body.queue_free()
	# Delete this enemy.
	queue_free()


# This is called when an Area2D hitbox enters the enemy's hitbox.
func _on_area_entered(area):
	# Check to see if the Area2D is the player's AttackHitbox.
	if area.name == "AttackHitboxParent":
		# Delete this enemy.
		queue_free()
