extends Node2D

signal mucus_upgraded(level)
var level
var map_node
var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type

var current_wave = 0
var between_waves = true
var enemies_in_wave = 0

var base_health
var health_label
var money = 100
var money_label
var quit_button
var pause_play_button

var waves_data
var num_waves

var mucus_level = 0
var mucus_cost = GameData['tower_data']['mucus']['cost'][0]

# Called when the node enters the scene tree for the first time.
func _ready():
	if level == 1 or level == 2:
		map_node = load("res://Scenes/Maps/map_1.tscn").instantiate()
	else:
		map_node = load("res://Scenes/Maps/map_2.tscn").instantiate()
	base_health = GameData['level_data'][level]['starting_hp']
	waves_data = GameData['level_data'][level]['wave_data']
	num_waves = waves_data.size()
	add_child(map_node)
	for b in get_tree().get_nodes_in_group("build_buttons"):
		b.connect("pressed", self.initiate_build_node.bind(b.get_name()))
	health_label = get_node("UI/HUD/InfoBar/H/Health")
	health_label.text = str(base_health)
	money_label = get_node("UI/HUD/InfoBar/H/DP")
	money_label.text = str(money)
	
	quit_button = get_node("UI/HUD/InfoBar/H/QuitButton")
	quit_button.connect("pressed", on_quit_game)
	
	pause_play_button = get_node("UI/HUD/GameControls/PausePlay")
	# start_next_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if build_mode:
		update_tower_preview()
	if !between_waves and enemies_in_wave == 0:
		if current_wave == num_waves:
			var win_scene = load("res://Scenes/UIScenes/win_menu.tscn").instantiate()
			get_parent().add_child(win_scene)
			queue_free()
			return
		between_waves = true
		money += 100
		money_label.text = str(money)
		pause_play_button.button_pressed = false
	
func _unhandled_input(event):
	if event.is_action_released('ui_accept') and build_mode:
		verify_and_build()
		cancel_build_mode()
		
	elif event.is_action_released('ui_cancel') and build_mode:
		cancel_build_mode()

#WAVE FUNCS
func start_next_wave():
	print("starting wave", current_wave)
	var wave_data = retrieve_wave_data(current_wave)
	between_waves = false
	current_wave +=1
	await get_tree().create_timer(1).timeout
	spawn_enemies(wave_data)
	
func retrieve_wave_data(current_wave):
	#[enemy_name, timeout]
	var wave_data = waves_data[current_wave]
	enemies_in_wave = wave_data.size()
	print("enemies_in_wave", enemies_in_wave)
	return wave_data

func spawn_enemies(wave_data):
	for enemy in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + enemy[0] + ".tscn").instantiate()
		new_enemy.health = enemy[2]
		new_enemy.type = enemy[0]
		new_enemy.speed_multiplier = 1 - GameData['tower_data']['mucus']['slowdown'][mucus_level]
		new_enemy.connect("base_damage", on_base_damage)
		new_enemy.connect("enemy_death", on_enemy_death)
		map_node.get_node("Path").add_child(new_enemy, true)
		await get_tree().create_timer(enemy[1]).timeout

#BUILDING FUNCS
func initiate_build_node(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type
	if tower_type == 'mucus':
		upgrade_mucus()
	else:
		build_mode = true
		get_node("UI").set_tower_preview(tower_type, get_global_mouse_position())
	
func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var path_node = map_node.get_node("TowerExclusion")
	var current_tile = path_node.local_to_map(mouse_position)
	var tile_position = path_node.map_to_local(current_tile)
	if money >= GameData['tower_data'][build_type]['cost'] and path_node.get_cell_source_id(0, current_tile) == -1:
		for t in get_node(map_node.get_name()+"/Towers").get_children():
			if t.position == tile_position:
				get_node("UI").update_tower_preview(tile_position, "e9080878")
				build_valid = false
				return
		get_node("UI").update_tower_preview(tile_position, '0fe908b4')
		build_valid = true
		build_tile = current_tile
		build_location = tile_position
	else:
		get_node("UI").update_tower_preview(tile_position, 'e9080878')
		build_valid = false
		
func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").free()
	
func verify_and_build():
	if build_valid:
		#Test for cash, deduct cash, update cash
		var new_tower = load("res://Scenes/Towers/" + build_type + ".tscn").instantiate()
		print(build_type)
		new_tower.position = build_location
		new_tower.built = true
		new_tower.type = build_type
		new_tower.tower_range = GameData['tower_data'][build_type]['range']
		money -= GameData['tower_data'][build_type]['cost']
		money_label.text = str(money)
		map_node.get_node("Towers").add_child(new_tower, true)
		map_node.get_node("TowerExclusion").set_cell(0, build_tile, 5)

func upgrade_mucus():
	if money >= mucus_cost:
		money -= mucus_cost
		money_label.text = str(money)
		mucus_level += 1
		mucus_cost = GameData['tower_data']['mucus']['cost'][mucus_level]
		emit_signal("mucus_upgraded", mucus_level)
		

#HEALTH AND MONEY FUNCS
func on_base_damage(damage):
	base_health -= damage
	health_label.text = str(base_health)
	if base_health <= 0:
		var death_scene = load("res://Scenes/UIScenes/death_menu.tscn").instantiate()
		get_parent().add_child(death_scene)
		queue_free()
		return
	enemies_in_wave -= 1
		
func on_enemy_death():
	money += 10
	money_label.text = str(money)
	enemies_in_wave -= 1

#UI FUNCS
func on_quit_game():
	queue_free()
	
func _on_pause_play_pressed():
	if get_tree().is_paused():
		get_tree().paused=false
	elif between_waves:
		start_next_wave()
	else:
		get_tree().paused=true


