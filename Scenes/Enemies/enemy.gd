extends PathFollow2D

var health
var health_label
var type
signal base_damage(damage)
signal enemy_death()
var speed_multiplier = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	rotates = false
	get_parent().get_parent().get_parent().connect("mucus_upgraded", on_mucus_upgrade)
	health_label = get_node("CharacterBody2D/Health")
	health_label.text = str(health)

func _physics_process(delta):
	move(delta)
	
func move(delta):
	if get_progress_ratio() == 1.0:
		emit_signal("base_damage", health)
		queue_free()
	else:
		set_progress(get_progress() + GameData.enemy_data[type]['speed'] * delta * speed_multiplier)

func on_mucus_upgrade(level):
	speed_multiplier = 1 - GameData['tower_data']['mucus']['slowdown'][level]

func on_hit(damage):
	health -= damage
	health_label.text = str(max(0,health))
	if health <= 0:
		print("emitted death", self)
		emit_signal("enemy_death")
		on_destroy()

func on_destroy():
	queue_free()
