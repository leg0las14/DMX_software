extends Node

var configFilePath = "res://ressource/configFiles/"
var structure_list
var decoration_list
var spot_list ={}


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


func CreateNew (pos, type):

	var spot = load(type)
	var spot_ = spot.instantiate()
	spot_.transform.origin = pos
	get_tree().get_root().add_child(spot_)
