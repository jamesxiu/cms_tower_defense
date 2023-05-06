extends Node

var tower_data = {
	"tower_1": {
		"range": 350,
		"rate": 0.5,
		"damage": 1,
		"cost": 50
	}
}

var enemy_data = {
	"enemy_1": {
		'speed': 150,
		'health': 3
	}
}

var level_data = {
	1: {
		'starting_hp': 20,
		'wave_data': [
			#name, timeout, health
			[['enemy_1', 0.7, 3], ['enemy_1', 0.1, 3]],
			[['enemy_1', 0.7, 5], ['enemy_1', 0.1, 5], ['enemy_1', 0,1, 5]]
		]
	}
}
