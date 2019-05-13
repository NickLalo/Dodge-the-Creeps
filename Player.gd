extends Area2D

# Declare member variables here. Examples:
export var speed = 300  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
signal hit

#Vector2 creates an array of x and y floats used for positional 2D math
	#initialized as (0,0)
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func _on_Player_body_entered(body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.call_deferred("set_disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# resetting velocity in the process loop allows for constant speed
	# even though the code looks like it would accelerate.
	velocity = Vector2()  # The player's movement vector.
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		# normalize is a vector term that makes the output magnitued equal
		# to 1 no matter what the angle combined by the values
		# we need this to not have extra fast diagonal speeds
		velocity = velocity.normalized() * speed
		
		#$ is shorthand for get_node("AnimatedSprite")
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# update position
	position += velocity * delta
	# float clamp ( float input value, float min, float max )
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# if there is anything other than idle
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		# reset vertical flip so we are standing upright
		$AnimatedSprite.flip_v = false
		# use a bool to set the value for left right facing
		$AnimatedSprite.flip_h = velocity.x < 0
		
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	

