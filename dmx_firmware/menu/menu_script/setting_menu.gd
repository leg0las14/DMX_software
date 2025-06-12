extends Control

var window
var param_button
var arbo_button
var retract_button_open
var retract_button_close
var spot_list
var parametre_list

func _ready() -> void:
	window = $"%window"
	param_button = $"%param_button"
	arbo_button = $"%arbo_button"
	retract_button_close = $"%retract_button_close"
	retract_button_open = $"%retract_button_open"
	spot_list = $"%ListSpotMenu"
	parametre_list = $"%parametre"

	retract_button_close.visible = false
	spot_list.visible = false
	parametre_list.visible = true
	
	arbo_button.modulate = Color(1, 1, 1, 1)
	param_button.modulate = Color(1, 0, 0, 1)
	Simulation.changeFog(0)

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

func _on_fog_slicer_value_changed(value: float) -> void:
	Simulation.changeFog(value)
