# TODO : faire pour bouton 3 et 4
# supprimer tout les commentaires inutile après

extends Control

var button1
var button2

func _ready() -> void:
	# récupère le bouton
	#############
	# ATTENTION : Bien faire 'clique droit' sur le bouton puis "Acces as unique name" (symbole de %)
	#############
	button1 = $HBoxContainer/Button
	button2 = $HBoxContainer/Button2
	# Modifie ça couleur de départ (R, G, B, Alpha)

	button1.modulate = Color(1, 0, 0, 1)
	button2.modulate = Color(1, 1, 1, 1)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed():
	button1.modulate = Color(1, 0, 0, 1)
	button2.modulate = Color(1, 1, 1, 1)

func _on_button_2_pressed():
	button1.modulate = Color(1, 1, 1, 1)
	button2.modulate = Color(1, 0, 0, 1)
