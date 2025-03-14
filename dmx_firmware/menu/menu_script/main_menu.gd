extends Control

var button1
var button2
var button3
var button4

func _ready() -> void:
	# récupère le bouton
	#############
	# ATTENTION : Bien faire 'clique droit' sur le bouton puis "Acces as unique name" (symbole de %)
	#############
	button1 = $HBoxContainer/Button
	button2 = $HBoxContainer/Button2
	button3 = $HBoxContainer/Button3
	button4 = $HBoxContainer/Button4
	# Modifie ça couleur de départ (R, G, B, Alpha)

	button1.modulate = Color(1, 0, 0, 1)
	button2.modulate = Color(1, 1, 1, 1)
	button3.modulate = Color(1, 1, 1, 1)
	button4.modulate = Color(1, 1, 1, 1)


func _on_button_pressed():
	button1.modulate = Color(1, 0, 0, 1)
	button2.modulate = Color(1, 1, 1, 1)
	button3.modulate = Color(1, 1, 1, 1)
	button4.modulate = Color(1, 1, 1, 1)

func _on_button_2_pressed():
	button1.modulate = Color(1, 1, 1, 1)
	button2.modulate = Color(1, 0, 0, 1)
	button3.modulate = Color(1, 1, 1, 1)
	button4.modulate = Color(1, 1, 1, 1)

func _on_button_3_pressed():
	button1.modulate = Color(1, 1, 1, 1)
	button2.modulate = Color(1, 1, 1, 1)
	button3.modulate = Color(1, 0, 0, 1)
	button4.modulate = Color(1, 1, 1, 1)

func _on_button_4_pressed():
	button1.modulate = Color(1, 1, 1, 1)
	button2.modulate = Color(1, 1, 1, 1)
	button3.modulate = Color(1, 1, 1, 1)
	button4.modulate = Color(1, 0, 0, 1)
