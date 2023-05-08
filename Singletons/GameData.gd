extends Node

var tower_data = {
	"tower_1": {
		"range": 200,
		"rate": 0.5,
		"damage": 1,
		"cost": 50
	},
	"tower_2": {
		"range": 300,
		"rate": 1,
		"damage": 2,
		"cost": 100
	}
}

var enemy_data = {
	"enemy_1": {
		'speed': 150,
	},
	"enemy_2": {
		'speed': 150,
	}
}

var level_data = {
	1: {
		'starting_hp': 20,
		'wave_data': [
			#name, timeout, health
			[['enemy_1', 0.7, 3], ['enemy_2', 0.1, 3]],
			[['enemy_1', 0.7, 5], ['enemy_2', 0.1, 5], ['enemy_1', 0.1, 5]]
		]
	},
	2: {
		'starting_hp': 30,
		'wave_data': [
			#name, timeout, health
			[['enemy_1', 0.7, 3], ['enemy_2', 0.1, 3]],
			[['enemy_1', 0.7, 5], ['enemy_2', 0.1, 5], ['enemy_1', 0.1, 5]]
		]
	},
	3: {
		'starting_hp': 40,
		'wave_data': [
			#name, timeout, health
			[['enemy_1', 0.7, 1]],
		]
	}
}
