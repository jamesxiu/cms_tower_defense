extends Node2D

var map_node
var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type

var current_wave = 0
var enemies_in_wave = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	map_node = get_node("Map1")
	for b in get_tree().get_nodes_in_group("build_buttons"):
		b.connect("pressed", self.initiate_build_node.bind(b.get_name()))
	start_next_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if build_mode:
		update_tower_preview()
	
func _unhandled_input(event):
	if event.is_action_released('ui_accept') and build_mode:
		verify_and_build()
		cancel_build_mode()
	elif event.is_action_released('ui_cancel') and build_mode:
		cancel_build_mode()

#WAVE FUNCS
func start_next_wave():
	var wave_data = retrieve_wave_data()
	await get_tree().create_timer(1).timeout
	spawn_enemies(wave_data)
	
func retrieve_wave_data():
	#[enemy_name, timeout]
	var wave_data = [['enemy_1', 0.7], ['enemy_1', 0,1]]
	current_wave +=1
	enemies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data):
	for enemy in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + enemy[0] + ".tscn").instantiate()
		map_node.get_node("Path").add_child(new_enemy, true)
		await get_tree().create_timer(enemy[1]).timeout

#BUILDING FUNCS
func initiate_build_node(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type
	build_mode = true
	get_node("UI").set_tower_preview(tower_type, get_global_mouse_position())
	
func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var path_node = map_node.get_node("TowerExclusion")
	var current_tile = path_node.local_to_map(mouse_position)
	var tile_position = path_node.map_to_local(current_tile)
	if path_node.get_cell_source_id(0, current_tile) == -1:
		for t in get_node("Map1/Towers").get_children():
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
		new_tower.position = build_location
		map_node.get_node("Towers").add_child(new_tower, true)
		map_node.get_node("TowerExclusion").set_cell(0, build_tile, 5)
		
	


