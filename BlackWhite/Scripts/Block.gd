extends Node2D

const BLOCK_SIZE = 64

var grid_position = Vector2(0, 0)

func set_grid_position(pos):
	print("Moving block to {pos}".format({"pos" : str(pos)}))
	var pixel_pos = Vector2(pos.x * BLOCK_SIZE, pos.y * BLOCK_SIZE)
	position = pixel_pos
	grid_position = pos