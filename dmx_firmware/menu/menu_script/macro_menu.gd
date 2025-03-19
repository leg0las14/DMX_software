extends Control

var window
var ouvrir

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window = $"%window"
	ouvrir = $"%ouvrir"
	pass # Replace with function body.


func _on_fermer_pressed() -> void:
	window.visible =false
	ouvrir.visible =true
	pass # Replace with function body.


func _on_ouvrir_pressed() -> void:
	window.visible =true
	pass # Replace with function body.
