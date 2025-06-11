extends HBoxContainer

var id = 0

func _exit_tree() -> void:
	for i in ModelManager.sceneEntities:
		if i.id == id:
			i.arbo_instance = null

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
