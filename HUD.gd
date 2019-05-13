extends CanvasLayer

# Declare member variables here. Examples:
signal start_game
# var b = "text"

func show_message(text):
	$MessageLabel.text = text
	
	$MessageLabel.show()
	$MessageTimer.start()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func show_game_over():
	
	# outputs "Game Over" text then yelid calls a timer that stops execution of the code
	# here until "timeout" has returned.  This will allow gameover to be on the screen
	# for 2 seconds before moving on to the next lines of code
	show_message("Game \nOver")
	yield($MessageTimer, "timeout")
	
	# Outputs "doged the creeps" text, waits 1 second, and then puts up the start button
	$MessageLabel.text = "Dodge\nthe\nCreeps!"
	$MessageLabel.show()
	yield(get_tree().create_timer(1), 'timeout')
	
	$StartButton.show()

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
