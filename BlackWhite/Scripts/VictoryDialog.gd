extends PopupDialog

func _ready():
	get_node("Button").connect("button_up", self, "load_menu")

func load_menu():
	get_tree().change_scene("res://Levels/MainMenu.tscn")