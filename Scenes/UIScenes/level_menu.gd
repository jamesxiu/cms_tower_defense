extends Control

func _ready():
	get_node("Margin/GridContainer/Level1").connect("pressed", self.on_level.bind(1))
	get_node("Margin/GridContainer/Level2").connect("pressed", self.on_level.bind(2))
	get_node("Margin/GridContainer/Level3").connect("pressed", self.on_level.bind(3))
	get_node("Margin/GridContainer/Back").connect("pressed", self.on_back)
	

func on_level(level):
	# get_node("MainMenu/Margin/VBoxContainer/NewGame").queue_free()
	var game_scene = load("res://Scenes/MainScenes/game_scene.tscn").instantiate()
	print(game_scene.level)
	game_scene.level = level
	get_parent().add_child(game_scene)
	queue_free()
	
func on_back():
	queue_free()
