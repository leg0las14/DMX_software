extends Node

var configFilePath = "res://ressource/configFiles/"
var structure_list = {}
var decoration_list = {}
var spot_names = []
var objects: Array

class Spot_local:
	var name
	var prefab
	var src

func _ready() -> void:
	initListSpot()

func initListSpot() -> void:
	var files = JsonSingletonMutex.getConfigFileList(configFilePath)
	for i in files:
		var full_path = configFilePath + i
		var data = JsonSingletonMutex.readJson(full_path)
		if "spot" in data:
			var new_spot = Spot_local.new()
			var spot = data["spot"]
			new_spot.name = spot["name"]
			new_spot.prefab = spot["prefab"]
			new_spot.src = full_path
			spot_names.append(new_spot)
			print(spot_names[0].name)


func CreateNew (pos, path, src = null):
	var object = load(path)
	var objectInstance = object.instantiate()
	objectInstance.init(src)
	objectInstance.transform.origin = pos
	get_tree().get_root().add_child(objectInstance)
	objects.append(objectInstance)
	print(objects)

func attachToObjetc(spot: Node3D, object: Node3D):
	if spot.get_parent() != object:
		var global_pos = spot.global_transform.origin
		spot.get_parent().remove_child(spot)
		object.add_child(spot)
		spot.position = object.to_local(global_pos)
		print(spot.name + " attaché à " + object.name)

func detachFromObject(spot: Node3D):
	var root = get_tree().get_root()
	var global_pos = spot.global_transform.origin
	spot.get_parent().remove_child(spot)
	root.add_child(spot)
	spot.position = global_pos
	print(spot.name + " détaché du truss")
