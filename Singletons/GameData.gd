extends Node

var tower_data = {
	"mucus": {
		'slowdown': [0, .15, .3, .4, .5],
		'cost': [100, 200, 300, 400, 100000000]
	},
	"neutrophil": {
		"range": 250,
		"rate": 0.7,
		"damage": 1,
		"cost": 60
	},
	"macrophage": {
		"range": 150,
		"rate": 1.5,
		"damage": 2,
		"cost": 40
	},
	"dendritic": {
		"range": 300,
		"rate": 100,
		"damage": 0,
		"cost": 80
	},
	"b_cell": {
		"range": 250,
		"rate": 0.5,
		"damage": 3,
		"cost": 150
	},
	"helper_t": {
		"range": 300,
		"rate": 100,
		"damage": 0,
		"cost": 400
	},
	"cytotoxic_t": {
		"range": 150,
		"rate": 2,
		"damage": 15,
		"cost": 250
	},
}

var enemy_data = {
	"enemy_1": {
		'speed': 150,
	},
	"enemy_2": {
		'speed': 200,
	},
	"enemy_3": {
		'speed': 250
	},
	"enemy_4": { # bacteria move slower than viruses but have higher health (indicating they are more persistent)
		'speed': 100
	},
	"enemy_5": {
		'speed': 125
	}
}

var level_data = {
	1: {
		'starting_hp': 20,
		'wave_data': [
			#name, timeout, health
			[['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5]], # 5
			[['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5]], # 8
			[['enemy_1', 0.3, 5], ['enemy_1', 0.3, 5], ['enemy_1', 0.3, 5], ['enemy_1', 0.3, 5], ['enemy_1', 0.5, 5], ['enemy_1', 0.5, 5], ['enemy_1', 0.5, 5], ['enemy_1', 0.5, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5], ['enemy_1', 0.7, 5]], #12 
			[['enemy_1', 0.5, 5], ['enemy_1', 0.5, 5], ['enemy_2', 0.5, 10], ['enemy_1', 0.5, 5], ['enemy_2', 0.5, 10], ['enemy_1', 0.5, 5], ['enemy_2', 0.5, 10], ['enemy_1', 0.5, 5]], # 8
			[['enemy_2', 0.3, 10], ['enemy_2', 0.3, 10], ['enemy_2', 0.3, 10], ['enemy_2', 0.3, 10], ['enemy_1', 0.5, 5], ['enemy_1', 0.5, 5], ['enemy_1', 0.5, 5], ['enemy_1', 0.5, 5]], # 8
			[['enemy_2', 0.3, 10], ['enemy_2', 0.3, 10], ['enemy_2', 0.3, 10], ['enemy_2', 0.3, 10], ['enemy_2', 0.3, 10], ['enemy_3', 0.5, 15], ['enemy_2', 0.3, 10], ['enemy_3', 0.5, 15]], # 8
			[['enemy_3', 0.3, 15], ['enemy_3', 0.3, 15], ['enemy_3', 0.3, 15], ['enemy_2', 0.3, 10], ['enemy_2', 0.3, 10], ['enemy_2', 0.3, 10], ['enemy_2', 0.3, 10]], # 8 
			[['enemy_3', 0.2, 15], ['enemy_3', 0.2, 15], ['enemy_2', 0.5, 10], ['enemy_3', 0.2, 15], ['enemy_3', 0.2, 15], ['enemy_2', 0.3, 10], ['enemy_3', 0.2, 15], ['enemy_3', 0.2, 15]] # 8
			
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
