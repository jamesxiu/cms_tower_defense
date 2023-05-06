extends PathFollow2D

var health
signal base_damage(damage)
signal enemy_death()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func init(starting_health):
	health = starting_health

func _physics_process(delta):
	move(delta)
	
func move(delta):
	if get_progress_ratio() == 1.0:
		emit_signal("base_damage", health)
		queue_free()
	else:
		set_progress(get_progress() + GameData.enemy_data['enemy_1']['speed'] * delta)
	
func on_hit(damage):
	health -= damage
	print(health)
	if health <= 0:
		emit_signal("enemy_death")
		on_destroy()

func on_destroy():
	queue_free()
