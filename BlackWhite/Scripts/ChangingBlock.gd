extends "Block.gd"

enum block_color {BLACK, WHITE}

var current_color = block_color.BLACK
onready var black_sprite = get_node("BlackSprite")
onready var white_sprite = get_node("WhiteSprite")
onready var collider = get_node("PlayerCollision")

func _ready():
	get_node("PlayerDetection").connect("body_exited", self, "on_player_left")

func on_player_left(player):
	print("Player left block")
	switch_color()

func set_color(color):
	match color:
		block_color.WHITE:
			print("Making block white")
			current_color = block_color.WHITE
			black_sprite.hide()
			white_sprite.show()
			collider.set_collision_layer_bit(0, true)
			collider.set_collision_layer_bit(1, false)
			collider.set_collision_mask_bit(0, true)
			collider.set_collision_mask_bit(1, false)
		block_color.BLACK:
			print("Making block black")
			current_color = block_color.BLACK
			black_sprite.show()
			white_sprite.hide()
			collider.set_collision_layer_bit(1, true)
			collider.set_collision_layer_bit(0, false)
			collider.set_collision_mask_bit(1, true)
			collider.set_collision_mask_bit(0, false)

func switch_color():
	print("Switching block colors")
	match current_color:
		block_color.BLACK:
			set_color(block_color.WHITE)
		block_color.WHITE:
			set_color(block_color.BLACK)
		_:
			print("Unknown block color...")