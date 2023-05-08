extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("MainMenu/Margin/HBoxContainer/NewGame").connect("pressed", self.on_new_game)
	get_node("MainMenu/Margin/HBoxContainer/QuitGame").connect("pressed", self.quit_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_new_game():
	# get_node("MainMenu/Margin/VBoxContainer/NewGame").queue_free()
	var level_scene = load("res://Scenes/UIScenes/level_menu.tscn").instantiate()
	add_child(level_scene)
	
func quit_game():
	get_tree().quit()
