extends Node2D
var message = "Top"

func _ready():
	#var message = "Hello World!"
	get_node("RichTextLabel").set_text(message)
	
	pass
	