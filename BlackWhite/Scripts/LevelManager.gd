extends Node2D

export (int) var level_number

var block_scene = preload("res://GameObjects/ChangingBlock.tscn")
var wall_scene = preload("res://GameObjects/Wall.tscn")
var goal_scene = preload("res://GameObjects/Goal.tscn")
var black_player_scene = preload("res://GameObjects/BlackPlayer.tscn")
var white_player_scene = preload("res://GameObjects/WhitePlayer.tscn")
var black_tutorial = preload("res://GUI/BlackTutorial.tscn")
var white_tutorial = preload("res://GUI/WhiteTutorial.tscn")
var victory_popup_scene = preload("res://GUI/VictoryDialog.tscn")

onready var block_parent = get_node("Blocks")
onready var goal_parent = get_node("Goals")
onready var player_parent = get_node("Players")
onready var gui_parent = get_node("GUI")

var current_goals = {}
var data_path = "res://Levels/Data/{lvl}.txt"

func _ready():
	if level_number == 0:
		print("Setting up test level")
		setup_test_level()
	else:
		print("Setting up level {num}".format({"num" : level_number}))
		setup_level(level_number)

func add_goal(x, y, is_black):
	var goal = goal_scene.instance()
	goal_parent.add_child(goal)
	goal.set_grid_position(Vector2(x, y))
	if(is_black):
		goal.set_color(goal.goal_color.BLACK)
	else:
		goal.set_color(goal.goal_color.WHITE)
	goal.connect("player_enters", self, "check_victory")
	var next_id = current_goals.size()
	goal.id = next_id
	current_goals[next_id] = goal

func add_block(x, y, is_black):
	var block = block_scene.instance()
	block_parent.add_child(block)
	block.set_grid_position(Vector2(x, y))
	if(is_black):
		block.set_color(block.block_color.BLACK)
	else:
		block.set_color(block.block_color.WHITE)

func add_wall(x, y):
	var wall = wall_scene.instance()
	wall.set_grid_position(Vector2(x, y))
	block_parent.add_child(wall)

func add_player(x, y, is_black):
	var player = null
	if(is_black):
		player = black_player_scene.instance()
	else:
		player = white_player_scene.instance()
	player.set_grid_position(Vector2(x, y))
	player_parent.add_child(player)

func check_victory():
	for key in current_goals:
		if not current_goals[key].goal_reached:
			return
	
	win()

func win():
	var dialog = victory_popup_scene.instance()
	gui_parent.add_child(dialog)
	dialog.popup()
	print("You won!")

func clear_level():
	for node in block_parent.get_children():
		node.free()
	for node in goal_parent.get_children():
		node.free()
	for node in player_parent.get_children():
		node.free()
	for node in gui_parent.get_children():
		node.free()

func setup_test_level():
	#setup level
	for y in range(4):
		for x in range(5):
			var pos = Vector2(x, y)
			if(x != 0 and x != 4):
				if(y != 0  and y != 3):
					add_block(x, y, y == 1)
					continue
			
			add_wall(x, y)
	
	#setup goals
	add_goal(3, 1, true)
	add_goal(1, 2, false)
	
	#setup players
	add_player(1, 1, false)
	add_player(3, 2, true)

func setup_level(level_number):
	var level_path = data_path.format({"lvl": level_number})
	var file = File.new()
	if not file.file_exists(level_path):
		print ("File not found...")
		return
	
	clear_level()
	file.open(level_path, file.READ)
	
	#setup level
	var x = 0
	var y = 0
	while not file.eof_reached():
		var line = file.get_line()
		if "end" in line:
			break
		for ch in line:
			match ch:
				"l":
					add_wall(x, y)
				"b":
					add_block(x, y, true)
				"w":
					add_block(x, y, false)
			x += 1
		x = 0
		y += 1
	
	#setup players and goals
	while not file.eof_reached():
		var line = file.get_line()
		if "end" in line:
			break
		var player_data = line.split(':')
		var is_black = player_data[0] == "black"
		var temp = player_data[1].split(',')
		add_player(temp[0], temp[1], is_black)
		temp = player_data[2].split(',')
		add_goal(temp[0], temp[1], is_black)
	
	#add extras
	while not file.eof_reached():
		var line = file.get_line()
		match line:
			"black_tutorial":
				var tutorial = black_tutorial.instance()
				gui_parent.add_child(tutorial)
			"white_tutorial":
				var tutorial = white_tutorial.instance()
				gui_parent.add_child(tutorial)
	
	file.close()