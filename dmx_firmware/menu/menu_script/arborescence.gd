extends HBoxContainer

var id = 0

func setName(name : String):
	$"%Label_nom_spot".text = name
	
func setId(id_ : int):
	id = id_

func _on_dell_button_pressed() -> void:
	ModelManager.DelElement(id)
	queue_free()

func select():
	print("trouvé")
	$"%Label_nom_spot".add_theme_color_override("font_color", Color.RED)

func unselect():
	$"%Label_nom_spot".add_theme_color_override("font_color", Color.WHITE)

func _on_label_nom_spot_pressed() -> void:
	ModelManager.selectedElement(id)
