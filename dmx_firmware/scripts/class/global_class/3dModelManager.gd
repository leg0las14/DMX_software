extends Node

var configFilePath = "res://ressource/configFiles/"
var structure_list = {}
var decoration_list = {}


var spot_names = []
class Spot_list:
	var name
	var prefab
	var src


var sceneEntities: Array
class Spot_instance:
	var id
	var instance
	var name
	var prefab
	var configFile
	var arbo_instance

var lastId = 0
var selectElement
var spotCanMove_ = true
var spotCanSelect_ = true

func _ready() -> void:
	initListSpot()

func initListSpot() -> void:
	var files = JsonSingletonMutex.getConfigFileList(configFilePath)
	for i in files:
		var full_path = configFilePath + i
		var data = JsonSingletonMutex.readJson(full_path)
		if "spot" in data:
			var new_spot = Spot_list.new()
			var spot = data["spot"]
			new_spot.name = spot["name"]
			new_spot.prefab = spot["prefab"]
			new_spot.src = full_path
			spot_names.append(new_spot)
			print(spot_names[0].name)

func CreateNew (pos, prefab, configFile = null):
	#Création de l'instance du spot
	var object = load(prefab)
	var objectInstance = object.instantiate()
	
	#Initialisation du spot en fonction du configFile
	objectInstance.init(configFile)
	objectInstance.setId(lastId)
	#Mettre à la position et afficher
	objectInstance.transform.origin = pos
	get_tree().get_root().add_child(objectInstance)

	#Création de l'objet de Spot_Instance contenant toutes les infos de l'instance
	var objectClasse = Spot_instance.new()
	objectClasse.id = lastId
	objectClasse.prefab = prefab
	objectClasse.configFile = configFile
	objectClasse.instance = objectInstance
	objectClasse.name = objectInstance.name_+ "_" + str(lastId)
	sceneEntities.append(objectClasse)
	#Envoie du signal pour mettre à jour la liste de spot
	var menus = get_tree().get_nodes_in_group("menu_list")
	if menus.size() > 0:
		menus[0].emit_signal("update_list_spot")
	lastId -=-1

func DelElement(id:int):
	for i in sceneEntities:
		if i.id == id:
			i.instance.queue_free()
			sceneEntities.erase(i)


func selectedElement(id_:int):
	selectElement = id_
	for i in sceneEntities:
		if i.id == id_ :
			#if i.arbo_instance:
			i.arbo_instance.select()
			i.instance.select()
		else:
			i.arbo_instance.unselect()
			i.instance.unselect()

func getSelectedElement():
	return selectElement

func spotCanSelect():
	return spotCanSelect_

func setspotCanSelect(status:bool):
	spotCanSelect_ = status

func setSpotCanMove(status):
	spotCanMove_ = status

func spotCanMove() -> bool:
	return spotCanMove_

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
