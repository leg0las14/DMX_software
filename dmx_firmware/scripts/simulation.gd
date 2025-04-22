extends Node3D

func _ready():

	add_menu("res://menu/main_menu.tscn")

func add_menu(menu_path: String):
	add_child(load(menu_path).instantiate())
