extends Control

var button1
var button2
var button3
var button4

var liste_menu:=[]

func _ready() -> void:
	

	add_menu("res://menu/add_element_menu.tscn")
	add_menu("res://menu/setting_menu.tscn")

	# récupère le bouton

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
	remove_alls_menu()
	add_menu("res://menu/add_element_menu.tscn")
	add_menu("res://menu/setting_menu.tscn")

func _on_button_2_pressed():
	button1.modulate = Color(1, 1, 1, 1)
	button2.modulate = Color(1, 0, 0, 1)
	button3.modulate = Color(1, 1, 1, 1)
	button4.modulate = Color(1, 1, 1, 1)
	remove_alls_menu()
	add_menu("res://menu/addressage_menu.tscn")
func _on_button_3_pressed():
	button1.modulate = Color(1, 1, 1, 1)
	button2.modulate = Color(1, 1, 1, 1)
	button3.modulate = Color(1, 0, 0, 1)
	button4.modulate = Color(1, 1, 1, 1)
	remove_alls_menu()
	add_menu("res://menu/macro_menu.tscn")
func _on_button_4_pressed():
	button1.modulate = Color(1, 1, 1, 1)
	button2.modulate = Color(1, 1, 1, 1)
	button3.modulate = Color(1, 1, 1, 1)
	button4.modulate = Color(1, 0, 0, 1)
	remove_alls_menu()
	add_menu("res://menu/enregistrement_menu.tscn")


func add_menu(menu_path: String):
	var menu_instance = load(menu_path).instantiate()
	add_child(menu_instance)
	liste_menu.append(menu_instance)

func remove_alls_menu()->void:
	for menu in liste_menu:
			remove_child(menu)
			menu.queue_free()
	liste_menu.clear()
