extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("MainMenu/Margin/VBoxContainer/NewGame").connect("pressed", self.on_new_game)
	get_node("MainMenu/Margin/VBoxContainer/QuitGame").connect("pressed", self.quit_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_new_game():
	get_node("MainMenu/Margin/VBoxContainer/NewGame").queue_free()
	var game_scene = load("res://Scenes/MainScenes/game_scene.tscn").instantiate()
	add_child(game_scene)
	
func quit_game():
	get_tree().quit()
