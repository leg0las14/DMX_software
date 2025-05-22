extends Control

var spot_button
var structure_button
var decoration_button
var list_items
var retract_button_open
var retract_button_close
var window
var items
var selected_item_data = null

enum MenuStatus {spot, structure, decoration}
var menu_status

var retract = false

func _ready():
	spot_button = $"%spot_button"
	structure_button = $"%structure_button"
	decoration_button = $"%decoration_button"
	list_items = $window/list_items
	retract_button_open = $"%retract_button_open"
	retract_button_close = $"%retract_button_close"
	window = $"%window"

	spot_button.modulate = Color(1, 0, 0, 1)
	structure_button.modulate = Color(1, 1, 1, 1)
	decoration_button.modulate = Color(1, 1, 1, 1)

	retract_button_close.visible = false

	list_items.clear()
	items = ModelManager.spot_names
	for i in items:
		list_items.add_item(i.name)
	menu_status = MenuStatus.spot

func _on_spot_button_pressed():
	spot_button.modulate = Color(1, 0, 0, 1)
	structure_button.modulate = Color(1, 1, 1, 1)
	decoration_button.modulate = Color(1, 1, 1, 1)
	
	items = ModelManager.spot_names
	list_items.clear()
	for i in items:
		list_items.add_item(i.name)
	menu_status = MenuStatus.spot

func _on_structure_button_pressed():
	spot_button.modulate = Color(1, 1, 1, 1)
	structure_button.modulate = Color(1, 0, 0, 1)
	decoration_button.modulate = Color(1, 1, 1, 1)

	items = ModelManager.structure_list
	list_items.clear()
	for i in items:
		list_items.add_item(i)
	menu_status = MenuStatus.structure

func _on_decoration_button_pressed():
	spot_button.modulate = Color(1, 1, 1, 1)
	structure_button.modulate = Color(1, 1, 1, 1)
	decoration_button.modulate = Color(1, 0, 0, 1)
	
	items = ModelManager.decoration_list
	list_items.clear()
	for i in items:
		list_items.add_item(i)
	menu_status = MenuStatus.decoration


func _on_exit_button_pressed():
	queue_free()


func _on_valid_button_pressed():
	valider()

func valider():
	if list_items.is_anything_selected():
		var item_index = list_items.get_selected_items()[0]
		match menu_status:
			MenuStatus.spot:
				ModelManager.CreateNew(Vector3(0, 0, 0), ModelManager.spot_names[item_index].prefab, ModelManager.spot_names[item_index].src)
			MenuStatus.structure:
				ModelManager.CreateNew(Vector3(0, 0, 0), ModelManager.structure_list[item_index])
			MenuStatus.decoration:
				ModelManager.CreateNew(Vector3(0, 0, 0), ModelManager.decoration_list[item_index])

func _on_retract_button_open_pressed() -> void:
	window.visible = false
	retract_button_close.visible = true
func _on_retract_button_close_pressed() -> void:
	window.visible = true
	retract_button_close.visible = false
