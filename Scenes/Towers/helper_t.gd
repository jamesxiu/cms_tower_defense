extends "res://Scenes/Towers/Towers.gd"

var specialty = ""
var specializable_towers = []
var spec_button

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
			var cont_process = true
			for t in specializable_towers:
				if t.spec_button.button_pressed:
					cont_process = false
			if !sell_button.button_pressed and cont_process:
				cancel_info_mode()
		
#Change specialty to last target that died in range
func select_target():
	pass
	

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
		#Show specialize button
		if specialty != "":
			print("Adding specialize buttons")
			for t in game_scene.map_node.get_node("Towers").get_children():
				if t.type in ['b_cell', 'cytotoxic_t']:
					print("Added specialize to", t)
					if t.specialty == '':
						specializable_towers.append(t)
						t.spec_button.show()
						t.spec_button.connect('pressed', specialize.bind(t))
					
func specialize(t):
	print("HERE!!", t.specialty)
	if t.specialty == '':
		t.specialty = specialty
		t.t_boost = 1.5
		t.add_specialty(specialty)
		print(t.specialty)
	cancel_info_mode()
		
func cancel_info_mode():
	info_mode=false
	get_node("RangeTexture").queue_free()
	sell_button.hide()
	for t in specializable_towers:
		if t.spec_button.is_connected('pressed', specialize.bind(t)):
			t.spec_button.disconnect('pressed', specialize.bind(t))
		t.spec_button.hide()
	specializable_towers = []

	
	


