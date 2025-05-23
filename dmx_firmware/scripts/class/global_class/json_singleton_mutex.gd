extends Node

var mutex:= Mutex.new()

func _ready():
	pass

func getConfigFileList(path: String) -> Array:
	var dir = DirAccess.open(path)
	var elements = []
	if dir:
		dir.list_dir_begin()  # Initialise la lecture du répertoire
		var fileName = dir.get_next()
		while fileName != "":
			if not dir.current_is_dir():  # Vérifie que ce n'est pas un dossier
				elements.append(fileName)
			fileName = dir.get_next()
	return elements



func writeJson() -> bool:
	mutex.lock()
	mutex.unlock()
	return true

func readJson(path:String) -> Dictionary:
	mutex.lock()
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	mutex.unlock()
	var json = JSON.new()
	var result = json.parse(content)
	if result != OK:
		print("error reading path :", path)
		return {}
	return json.get_data()
