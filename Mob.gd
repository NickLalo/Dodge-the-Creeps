extends RigidBody2D

# Declare member variables here. Examples:
export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
var mob_types = ["walk", "swim", "fly"]

# Called when the node enters the scene tree for the first time.
func _ready():
	# randi() % n means:
	# choose a random number between 0 and n-1
	#TODO: use randi_range instead of randi()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	
func _on_Visibility_screen_exited():
	queue_free()
