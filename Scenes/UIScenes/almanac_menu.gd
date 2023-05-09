extends Control

func _ready():
	get_node("Margin/HBoxContainer/Back").connect("pressed", self.on_back)
	
func on_back():
	queue_free()

