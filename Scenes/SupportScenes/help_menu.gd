extends Control


func _ready():
	get_node("CanvasLayer/HBoxContainer/Back").connect("pressed", self.on_back)
	
func on_back():
	var game_scene = get_parent().get_node("GameScene")
	game_scene.get_tree().paused=false
	game_scene.pause_play_button.show()
	queue_free()

