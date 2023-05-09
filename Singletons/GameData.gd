extends Node

var tower_data = {
	"mucus": {
		'slowdown': [0, .15, .3, .4, .5],
		'cost': [50, 200, 300, 400, 100000000]
	},
	"neutrophil": {
		"range": 200,
		"rate": 0.5,
		"damage": 1,
		"cost": 1
	},
	"macrophage": {
		"range": 300,
		"rate": 1,
		"damage": 2,
		"cost": 1
	},
	"dendritic": {
		"range": 300,
		"rate": 100,
		"damage": 0,
		"cost": 1
	},
	"b_cell": {
		"range": 300,
		"rate": 1,
		"damage": 5,
		"cost": 1
	},
	"helper_t": {
		"range": 300,
		"rate": 100,
		"damage": 0,
		"cost": 1
	},
	"cytotoxic_t": {
		"range": 150,
		"rate": 2,
		"damage": 15,
		"cost": 1
	},
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
			[['enemy_1', 0.7, 5], ['enemy_2', 0.1, 5], ['enemy_1', 0.1, 5]],
			[['enemy_1', 0.7, 10], ['enemy_2', 0.1, 10], ['enemy_1', 0.1, 10]],
			[['enemy_1', 0.7, 20], ['enemy_2', 0.1, 20], ['enemy_1', 0.1, 20]],
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
