extends Node

var type
var tower_range
var enemy_array = []
var built = false
var target
var ready_to_fire = true
var info_mode = false
var sell_button
var game_scene

func _ready():
	sell_button = get_node("CanvasLayer/SellButton")
	sell_button.hide()
	if built:
		game_scene = get_parent().get_parent().get_parent()
		get_node("CanvasLayer/SellButton/Label").text = "Sell (" + str(GameData['tower_data'][type]['cost']/2) + " DP)"
		sell_button.connect("pressed", sell_tower)
		get_node("Range/CollisionShape2D").get_shape().radius = tower_range
		var infobutton = Button.new()
		infobutton.modulate = Color("ffffff00")
		infobutton.connect("pressed", on_infobutton_pressed)
		infobutton.position = self.position-Vector2(30,30)
		infobutton.size = Vector2(60, 60)
		infobutton.set_name("InfoButton")
		get_node("CanvasLayer").add_child(infobutton)


func _physics_process(delta):
	if built and info_mode:
		if Input.is_action_just_pressed("LeftClick"):
			print("CLICK OFF OF INFO")
			if !sell_button.button_pressed:
				info_mode=false
				get_node("RangeTexture").queue_free()
				sell_button.hide()
		
	if enemy_array.size() > 0 and built:
		select_target()
		if ready_to_fire:
			fire()
	else:
		target = null
	
func select_target():
	var enemy_progress_array = []
	for enemy in enemy_array:
		enemy_progress_array.append(enemy.get_progress())
	var max_progress = enemy_progress_array.max()
	target = enemy_array[enemy_progress_array.find(max_progress)]

func fire():
	print("firing", target)
	ready_to_fire = false
	target.on_hit(GameData.tower_data[type]['damage'])
	await get_tree().create_timer(GameData.tower_data[type]['rate']).timeout
	print("reloaded")
	ready_to_fire = true
	
func _on_range_body_entered(body):
	if built:
		enemy_array.append(body.get_parent())

func _on_range_body_exited(body):
	if built:
		enemy_array.erase(body.get_parent())
		
func on_infobutton_pressed():
	var build_mode = game_scene.build_mode
	if !info_mode and !build_mode:
		info_mode = true
		var range_texture = Sprite2D.new()
		var scaling = tower_range/300.0
		range_texture.position = Vector2(0,0)
		range_texture.texture = load("res://Assets/UI/range_overlay.png")
		range_texture.scale = Vector2(scaling, scaling)
		range_texture.set_name("RangeTexture")
		add_child(range_texture)
		print("infobutton pressed")
		sell_button.show()
		
func sell_tower():
	game_scene.money += GameData['tower_data'][type]['cost'] / 2
	var money_label = game_scene.get_node("UI/HUD/InfoBar/H/DP")
	money_label.text = str(game_scene.money)
	queue_free()
	
func add_specialty(specialty_type):
	var specialty_sprite = Sprite2D.new()
	specialty_sprite.texture = load("res://Assets/Enemies/" + specialty_type + ".png")
	specialty_sprite.position = Vector2(20, 25)
	specialty_sprite.scale = Vector2(.6, .6)
	specialty_sprite.set_name("SpecialtySprite")
	add_child(specialty_sprite)
	
func clear_specialty_sprite():
	get_node("SpecialtySprite").queue_free()
	
		





