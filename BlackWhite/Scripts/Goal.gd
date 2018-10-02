extends "Block.gd"

enum goal_color {BLACK, WHITE}

signal player_enters

onready var detection = get_node("PlayerDetection")
onready var black_sprite = get_node("BlackSprite")
onready var white_sprite = get_node("WhiteSprite")

var id = -1
var goal_reached = false

func _ready():
	detection.connect("body_entered", self, "on_enter")

func on_enter(player):
	print("Player entered goal")
	goal_reached = true
	player.free()
	black_sprite.hide()
	white_sprite.hide()
	detection.set_collision_layer_bit(2, false)
	detection.set_collision_layer_bit(3, false)
	detection.set_collision_mask_bit(2, false)
	detection.set_collision_mask_bit(3, false)
	emit_signal("player_enters")

func set_color(color):
	match color:
		goal_color.WHITE:
			black_sprite.hide()
			white_sprite.show()
			detection.set_collision_layer_bit(2, true)
			detection.set_collision_layer_bit(3, false)
			detection.set_collision_mask_bit(2, true)
			detection.set_collision_mask_bit(3, false)
		goal_color.BLACK:
			black_sprite.show()
			white_sprite.hide()
			detection.set_collision_layer_bit(3, true)
			detection.set_collision_layer_bit(2, false)
			detection.set_collision_mask_bit(3, true)
			detection.set_collision_mask_bit(2, false)