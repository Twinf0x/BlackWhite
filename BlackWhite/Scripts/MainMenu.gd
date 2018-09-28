extends MarginContainer

func _ready():
	get_node("VBoxContainer/Button").connect("button_up", self, "load_test")

func load_test():
	get_tree().change_scene("res://Levels/TestLevel.tscn")