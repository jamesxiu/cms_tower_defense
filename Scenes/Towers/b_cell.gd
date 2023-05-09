extends "res://Scenes/Towers/Towers.gd"

var activated = false
var specialty='' # = enemy type
var spec_button
var t_boost = 1

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
		spec_button = TextureButton.new()
		spec_button.texture_normal = load("res://Assets/UI/blue_button12.png")
		spec_button.modulate = Color("a0ff3060")
		spec_button.stretch_mode = 0
		spec_button.position = self.position-Vector2(30,30)
		spec_button.size = Vector2(60, 60)
		spec_button.set_name("SpecButton")
		spec_button.hide()
		get_node("CanvasLayer").add_child(spec_button)

func _physics_process(delta):
	if built and info_mode:
		if Input.is_action_just_pressed("LeftClick"):
			if !sell_button.button_pressed:
				info_mode=false
				get_node("RangeTexture").queue_free()
				sell_button.hide()
	if enemy_array.size() > 0 and built and specialty != '':
		select_target()
		if ready_to_fire:
			fire()
	else:
		target = null
			
func fire():
	print("firing", target)
	ready_to_fire = false
	target.on_hit(GameData.tower_data[type]['damage']*t_boost)
	await get_tree().create_timer(GameData.tower_data[type]['rate']).timeout
	print("reloaded")
	ready_to_fire = true

func _on_range_body_entered(body):
	if built:
		var enemy = body.get_parent()
		if enemy.type == specialty: #MIGHT BE SUPER BUGGY (.equals maybe)
			enemy_array.append(enemy)
		

