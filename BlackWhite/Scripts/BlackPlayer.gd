extends "Block.gd"

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("black_right"):
		velocity.x += 1
	if Input.is_action_pressed("black_left"):
		velocity.x -= 1
	if Input.is_action_pressed("black_down"):
		velocity.y += 1
	if Input.is_action_pressed("black_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	move_and_slide(velocity)