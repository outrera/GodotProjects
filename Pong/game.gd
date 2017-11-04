extends Node2D

#constant
const PLAYERSPEED = 100
const INITBALLSPEED = 100

#variable
var screensize
var padSize
var ballDirection = Vector2(1.0,0.0)
var ballSpeed = INITBALLSPEED

func _ready():
	screensize = get_viewport_rect().size
	padSize = get_node("rightPlayer").get_texture().get_size()
	set_process(true)
	pass
	
func _process(delta):
	#ball position
	var ballPosition = get_node("ball").get_pos()
	
	#collides
	var leftCollider = Rect2(get_node("leftPlayer").get_pos() - padSize*0.5, padSize)
	var rightCollider = Rect2(get_node("rightPlayer").get_pos() - padSize*0.5,padSize)
	
	#variable for player positions
	var rightPlayerPosition = get_node("rightPlayer").get_pos()
	var leftPlayerPosition = get_node("leftPlayer").get_pos()
	
	# Check player Input and move the pads
	if (rightPlayerPosition.y > 0 and Input.is_action_pressed("ui_up")):
		rightPlayerPosition.y += -PLAYERSPEED * delta
	if(rightPlayerPosition.y < screensize.y and Input.is_action_pressed("ui_down")):
		rightPlayerPosition.y += PLAYERSPEED * delta
	if (leftPlayerPosition.y > 0 and Input.is_action_pressed("left_up")):
		leftPlayerPosition.y += -PLAYERSPEED * delta
	if(leftPlayerPosition.y < screensize.y and Input.is_action_pressed("left_down")):
		leftPlayerPosition.y += PLAYERSPEED * delta
	
	#Update ball position
	ballPosition += ballDirection * ballSpeed * delta
	
	if(ballPosition.y < 0 and ballDirection < 0) or (ballPosition.y > screensize.y and ballDirection.y >0):
		ballPosition.y = -ballDirection.y
	if(leftCollider.has_point(ballPosition) or rightCollider.has_point(ballPosition)):
		ballDirection.x = -ballDirection.x
		ballDirection.y = randf()*2 -1 
		ballDirection = ballDirection.normalized()
		if(ballSpeed<300):
			ballSpeed *= 1.4
	
	#Update the position of our players
	get_node("rightPlayer").set_pos(rightPlayerPosition)
	get_node("leftPlayer").set_pos(leftPlayerPosition)	
	get_node("ball").set_pos(ballPosition)
	
