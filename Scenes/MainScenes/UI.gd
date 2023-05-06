extends CanvasLayer

func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load("res://Scenes/Towers/" + tower_type + ".tscn").instantiate()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("0fe908b4")
	
	var range_texture = Sprite2D.new()
	var texture_pos = Vector2(0,0)
	var scaling = GameData.tower_data[tower_type]['range']/600.0
	range_texture.texture = load("res://Assets/UI/range_overlay.png")
	range_texture.scale = Vector2(scaling, scaling)
	range_texture.modulate = Color("0fe908b4")
	range_texture.set_name("RangeTexture")
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture, true)
	control.position = mouse_position
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child(get_node("TowerPreview"), 0)
	
func update_tower_preview(new_position, color):
	get_node("TowerPreview").position = new_position
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/RangeTexture").modulate = Color(color)
		get_node("TowerPreview/DragTower").modulate = Color(color)
		

func _on_pause_play_pressed():
	if get_tree().is_paused():
		get_tree().paused=false
	elif get_parent().between_waves:
		get_parent().start_next_wave()
	else:
		get_tree().paused=true
