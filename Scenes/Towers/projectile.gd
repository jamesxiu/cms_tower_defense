extends Sprite2D

var target
var steps = 10 #each projectile takes 5 _physics_process runs to hit target

func _physics_process(delta):
	if steps >= 1 and is_instance_valid(target):
		position = (target.position - position) / steps + position
		steps -= 1
#		print(self.position)
	else:
		queue_free()
