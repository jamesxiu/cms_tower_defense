extends Sprite2D

var target
var steps = 5 #each projectile takes 5 _physics_process runs to hit target

func _physics_process(delta):
	position = (target.position - position) / steps + position
	steps -= 1

	if steps == 0:
		queue_free()
	
