extends "res://Scenes/Towers/Towers.gd"

var specialty = ""
var specializable_towers = []
	

func _physics_process(delta):
	if built and info_mode:
		if Input.is_action_just_pressed("LeftClick"):
			var cont_process = true
			for t in specializable_towers:
				if t.spec_button.button_pressed:
					cont_process = false
			if !sell_button.button_pressed and cont_process:
				cancel_info_mode()
		
	if enemy_array.size() > 0 and built:
		select_target()
	else:
		target = null
		
#Change specialty to last target that died in range
func select_target():
	var enemy_progress_array = []
	for enemy in enemy_array:
		enemy_progress_array.append(enemy.get_progress())
	var max_progress = enemy_progress_array.max()
	var old_target = target
	target = enemy_array[enemy_progress_array.find(max_progress)]
	
	if old_target != target:
		print("new target", target)
		if is_instance_valid(old_target):
			old_target.disconnect("enemy_death", on_enemy_death)
		if specialty == "":
			print(specialty, "connecting to target")
			target.connect("enemy_death", on_enemy_death)
	
func on_enemy_death():
	specialty = target.type
	add_specialty(specialty)
	#Set Icon to virus
	
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
				if t.type in ['b_cell', 'helper_t']:
					print("Added specialize to", t)
					if t.specialty == '':
						specializable_towers.append(t)
						t.spec_button.show()
						t.spec_button.connect('pressed', specialize.bind(t))
					
func specialize(t):
	print("HERE!!", t.specialty)
	if t.specialty == "":
		t.specialty = specialty
		print(t.specialty)
		t.add_specialty(specialty)
		specialty = ""
		clear_specialty_sprite()
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
	

	
	
