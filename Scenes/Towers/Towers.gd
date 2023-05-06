extends Node

var type
var enemy_array = []
var built = false
var target
var ready_to_fire = true

func _ready():
	if built:
		get_node("Range/CollisionShape2D").get_shape().radius = 0.5*GameData.tower_data['tower_1']['range']
		
func _physics_process(delta):
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
	ready_to_fire = false
	target.on_hit(GameData.tower_data[type]['damage'])
	await get_tree().create_timer(GameData.tower_data[type]['rate']).timeout
	ready_to_fire = true
	
func _on_range_body_entered(body):
	if built:
		enemy_array.append(body.get_parent())

func _on_range_body_exited(body):
	if built:
		enemy_array.erase(body.get_parent())