extends Node

var tower_data = {
	"mucus": {
		'slowdown': [0, .15, .3, .4, .5],
		'cost': [100, 200, 300, 400, 100000000]
	},
	"neutrophil": {
		"range": 200,
		"rate": 0.7,
		"damage": 1,
		"cost": 75
	},
	"macrophage": {
		"range": 120,
		"rate": 2,
		"damage": 2,
		"cost": 50
	},
	"dendritic": {
		"range": 250,
		"rate": 100,
		"damage": 0,
		"cost": 75
	},
	"b_cell": {
		"range": 240,
		"rate": 0.7,
		"damage": 2,
		"cost": 150
	},
	"helper_t": {
		"range": 250,
		"rate": 100,
		"damage": 0,
		"cost": 250
	},
	"cytotoxic_t": {
		"range": 160,
		"rate": 2,
		"damage": 20,
		"cost": 200
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
		'starting_hp': 50,
		'wave_data': [
			#name, timeout, health
			[['enemy_1', 1, 1], ['enemy_2', 0.3, 3], ['enemy_3', 2, 2], ['enemy_4', 1, 5], ['enemy_1', 0.7, 5]], # 1
			
			[['enemy_4', 0.3, 3], ['enemy_5', 0.3, 3], ['enemy_4', 0.3, 3], ['enemy_4', 0.3, 3], ['enemy_5', 0.3, 3],
			['enemy_1', 0.3, 2], ['enemy_2', 0.3, 2], ['enemy_1', 0.3, 2], ['enemy_2', 0.3, 2], ['enemy_2', 0.7, 2]], # 2
			
			[['enemy_1', 0.2, 1], ['enemy_1', 0.2, 1], ['enemy_1', 0.2, 1], ['enemy_1', 0.2, 1], ['enemy_1', 3, 1],
			['enemy_2', 0.2, 1], ['enemy_2', 0.2, 1],['enemy_2', 0.2, 1], ['enemy_2', 0.2, 1], ['enemy_2', 3, 1],
			['enemy_3', 0.2, 1], ['enemy_3', 0.2, 1],['enemy_3', 0.2, 1], ['enemy_3', 0.2, 1], ['enemy_3', 3, 1]], # 3
			
			[['enemy_1', 0.2, 2], ['enemy_2', 0.2, 2],['enemy_3', 0.2, 2],['enemy_4', 0.2, 2],['enemy_5', 3, 2],
			['enemy_1', 0.2, 4],['enemy_1', 0.2, 3],['enemy_1', 0.2, 2],['enemy_1', 3, 1],['enemy_1', 0.2, 4],
			['enemy_1', 0.2, 3], ['enemy_1', 0.2, 2],['enemy_1', 3, 1],['enemy_1', 0.2, 5],['enemy_1', 0.2, 4],
			['enemy_1', 0.2, 3],['enemy_1', 0.2, 2],['enemy_1', 3, 1],['enemy_1', 0.2, 15]], # 4
			
			[['enemy_1', 0.2, 1], ['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],
			['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],
			['enemy_1', 0.2, 1], ['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],
			['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],['enemy_1', 0.2, 1],
			['enemy_1', 0.2, 1],['enemy_1', 3, 1],['enemy_1', 0.2, 30]], # 5
			
			[['enemy_1', 0.2, 2], ['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],
			['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],
			['enemy_1', 0.2, 2], ['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],
			['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],
			['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 0.2, 2],['enemy_1', 3, 2],
			['enemy_1', 0.2, 70]], # 6
			
			[['enemy_1', 0.2, 4], ['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],
			['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],
			['enemy_1', 0.2, 4], ['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 3, 4],
			['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],
			['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 0.2, 4],['enemy_1', 3, 5], #7
			['enemy_1', 0.2, 100],['enemy_2', 0.2, 1],['enemy_3', 0.2, 1]], # 6
			
			[['enemy_1', 0.2, 1], ['enemy_1', 0.2, 2],['enemy_1', 0.2, 3],['enemy_1', 0.2, 4],['enemy_1', 0.2, 5],
			['enemy_1', 0.2, 6],['enemy_1', 0.2, 7],['enemy_1', 0.2, 8],['enemy_1', 0.2, 9],['enemy_1', 3, 10],
			['enemy_1', 0.2, 5], ['enemy_1', 0.2, 5],['enemy_4', 0.2, 5],['enemy_4', 0.2, 5],['enemy_1', 0.2, 5],
			['enemy_1', 0.2, 5],['enemy_1', 0.2, 5],['enemy_5', 0.2, 5],['enemy_5', 0.2, 5],['enemy_1', 1, 5],
			['enemy_1', 0.2, 5],['enemy_1', 0.2, 5],['enemy_1', 0.2, 5],['enemy_1', 0.2, 5],['enemy_1', 3, 5],
			['enemy_1', 0.2, 30],['enemy_1', 0.2, 30],['enemy_1', 0.2, 30],['enemy_1', 5, 30],['enemy_1', 3, 100]], #8
			
			[['enemy_1', 0.2, 10], ['enemy_1', 0.2, 10],['enemy_1', 0.2, 10],['enemy_1', 0.2, 10],['enemy_1', 0.2, 10],
			['enemy_1', 0.2, 10],['enemy_1', 0.2, 10],['enemy_1', 0.2, 10],['enemy_1', 0.2, 10],['enemy_1', 3, 10],
			['enemy_2', 0.2, 5], ['enemy_2', 0.2, 5],['enemy_2', 0.2, 5],['enemy_2', 0.2, 5],['enemy_2', 0.2, 5],
			['enemy_2', 0.2, 5],['enemy_2', 0.2, 5],['enemy_2', 0.2, 5],['enemy_2', 0.2, 5],['enemy_2', 1, 5],
			['enemy_1', 0.2, 10],['enemy_1', 0.2, 10],['enemy_1', 0.2, 10],['enemy_1', 0.2, 10],['enemy_1', 3, 10],
			['enemy_1', 0.2, 40],['enemy_1', 0.2, 40],['enemy_1', 0.2, 40],['enemy_1', 0.2, 40],['enemy_1', 3, 40]], #9
			
			[['enemy_1', 0.1, 400]], #10
		]
	},
	2: {
		'starting_hp': 30,
		'wave_data': [
			#name, timeout, health
			[['enemy_5', 0.7, 1]],
			[['enemy_5', 0.7, 1]],
			[['enemy_5', 0.7, 1]],
			[['enemy_5', 0.7, 1]],
			[['enemy_5', 0.7, 1]],
			[['enemy_5', 0.7, 1]],
			[['enemy_5', 0.7, 1]],
			[['enemy_5', 0.7, 1]],
			[['enemy_5', 0.7, 1]],
			[['enemy_5', 0.7, 1]],
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
