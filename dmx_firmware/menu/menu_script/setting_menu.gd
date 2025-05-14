extends Control

var window
var param_button
var arbo_button
var retract_button_open
var retract_button_close
var spot_list
var parametre_list
@onready var vbox_container: VBoxContainer = $window/ColorRect/ScrollContainer/V_BOX


func _ready() -> void:
	window = $"%window"
	param_button = $"%param_button"
	arbo_button = $"%arbo_button"
	retract_button_close = $"%retract_button_close"
	retract_button_open = $"%retract_button_open"
	spot_list = $"%list_spot"
	parametre_list = $"%parametre_list"
	
	
	retract_button_close.visible = false
	spot_list.visible = false
	param_button.modulate = Color(1, 0, 0, 1)
	arbo_button.modulate = Color(1, 1, 1, 1)

func _on_param_button_pressed() -> void:
	param_button.modulate = Color(1, 0, 0, 1)
	arbo_button.modulate = Color(1, 1, 1, 1)
	spot_list.visible = false
	parametre_list.visible = true


func _on_arbo_button_pressed() -> void:
	param_button.modulate = Color(1, 1, 1, 1)
	arbo_button.modulate = Color(1, 0, 0, 1)
	spot_list.visible = true
	parametre_list.visible = false


func _on_retract_button_open_pressed() -> void:
	window.visible = false
	retract_button_close.visible = true
func _on_retract_button_close_pressed() -> void:
	window.visible = true
	retract_button_close.visible = false

func _input(event):
	if event.is_action_pressed("ajout_container"):
		var objet = Venv.selected_item_data
		add_container(objet)

func add_container(nom :String) -> void:
	var arborescence_scene =load("res://menu/arborescence.tscn")
	var instance = arborescence_scene.instantiate()
	
	var label_inside = instance.get_node("Label_nom_spot")
	label_inside.text = nom
	
	vbox_container.add_child(instance)
