extends Node2D

var block_scene = preload("res://GameObjects/ChangingBlock.tscn")
var wall_scene = preload("res://GameObjects/Wall.tscn")
var goal_scene = preload("res://GameObjects/Goal.tscn")
var black_player_scene = preload("res://GameObjects/BlackPlayer.tscn")
var white_player_scene = preload("res://GameObjects/WhitePlayer.tscn")

onready var block_parent = get_node("Blocks")
onready var goal_parent = get_node("Goals")
onready var player_parent = get_node("Players")

func _ready():
	print("Setting up test level")
	setup_test_level()


func setup_test_level():
	#setup level
	for x in range(5):
		for y in range(4):
			var pos = Vector2(x, y)
			if(x != 0 and x != 4):
				if(y != 0  and y != 3):
					var block = block_scene.instance()
					block_parent.add_child(block)
					block.set_grid_position(pos)
					if(y == 1):
						block.set_color(block.block_color.BLACK)
					else:
						block.set_color(block.block_color.WHITE)
					continue
			
			var wall = wall_scene.instance()
			wall.set_grid_position(pos)
			block_parent.add_child(wall)
	#setup goals
	var goal = goal_scene.instance()
	goal_parent.add_child(goal)
	goal.position = Vector2(64, 128)
	goal.set_color(goal.goal_color.WHITE)
	
	goal = goal_scene.instance()
	goal_parent.add_child(goal)
	goal.position = Vector2(192, 64)
	goal.set_color(goal.goal_color.BLACK)
	#setup players
	var player = white_player_scene.instance()
	player_parent.add_child(player)
	player.position = Vector2(64, 64)
	
	player = black_player_scene.instance()
	player_parent.add_child(player)
	player.position = Vector2(192, 128)