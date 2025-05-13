extends Node3D

func _ready():
	add_menu("res://menu/main_menu.tscn")

func add_menu(menu_path: String):
	var menu = load(menu_path).instantiate()
	menu.mainCamera = $"%CameraPivot"
	add_child(menu)
