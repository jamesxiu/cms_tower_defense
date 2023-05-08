extends "res://Scenes/Towers/Towers.gd"

var activated = false
var specialty# = enemy type

func _physics_process(delta):
	if activated:
		if enemy_array.size() > 0 and built:
			select_target()
			if ready_to_fire:
				fire()
		else:
			target = null

func _on_range_body_entered(body):
	if ! built:
		return

	var enemy = body.get_parent()
	if enemy.type == specialty: #MIGHT BE SUPER BUGGY (.equals maybe)
		enemy_array.append(enemy)

func _on_range_body_exited(body):
	if ! built:
		return
	
	var enemy = body.get_parent()

	#.erase() deletes only if it exists
	enemy_array.erase(enemy) #assumes different enemies of the same type are not recognized as the same during deletion
