extends Node3D

func _ready():
	var canvas_layer = CanvasLayer.new()
	add_child(canvas_layer)

	add_menu("res://menu/main_menu.tscn",canvas_layer)
	add_menu("res://menu/add_element_menu.tscn",canvas_layer)
	add_menu("res://menu/setting_menu.tscn", canvas_layer)

func add_menu(menu_path: String, canvas_layer: CanvasLayer):
	canvas_layer.add_child(load(menu_path).instantiate())
