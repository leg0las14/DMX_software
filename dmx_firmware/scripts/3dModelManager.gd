extends Node

var configFilePath = "res://ressource/configFiles/"
var structure_list ={}
var decoration_list ={}
var spot_list ={}

var objects:Array

func _ready() -> void:
	initListSpot()

func initListSpot()->void:
	var files = JsonSingletonMutex.getConfigFileList(configFilePath)
	for i in files:
		var data = JsonSingletonMutex.readJson(configFilePath+i)
		if "spot" in data:
			var spot = data["spot"]
			spot_list[spot["name"]] = spot["prefab"]
			print(spot_list)


func CreateNew (pos, path):
	var object = load(path)
	var objectInstance = object.instantiate()
	objectInstance.transform.origin = pos
	get_tree().get_root().add_child(objectInstance)
	objects.append(objectInstance)
	print(objects)
	objects[0].name = "cc"
	print(objects[0].name)

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
