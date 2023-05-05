extends PathFollow2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move(delta)
	
func move(delta):
	set_progress(get_progress() + GameData.enemy_data['enemy_1']['speed'] * delta)
	
