extends HBoxContainer

var id = 0

func setName(name : String):
	$"%Label_nom_spot".text = name
	
func setId(id_ : int):
	id = id_

func _on_dell_button_pressed() -> void:
	ModelManager.DelElement(id)
	queue_free()
