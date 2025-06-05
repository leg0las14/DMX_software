extends Control

signal update_list_spot

func _ready() -> void:
	connect("update_list_spot", Callable(self, "update_list_spot_"))
	add_to_group("menu_list")
	emit_signal("update_list_spot")

func update_list_spot_():
	var container = $"%list_element"

	for child in container.get_children():
		child.queue_free()

	for i in ModelManager.sceneEntities:
		var arbo = load("res://menu/arborescence.tscn")
		var arbo_i = arbo.instantiate()
		var label = arbo_i.get_node('Label_nom_spot')
		label.text = i.name
		container.add_child(arbo_i)
