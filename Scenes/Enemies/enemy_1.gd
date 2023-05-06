extends PathFollow2D

var health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	health = GameData.enemy_data['enemy_1']['health']

func _physics_process(delta):
	move(delta)
	
func move(delta):
	set_progress(get_progress() + GameData.enemy_data['enemy_1']['speed'] * delta)
	
func on_hit(damage):
	health -= damage
	print(health)
	if health <= 0:
		on_destroy()

func on_destroy():
	queue_free()
