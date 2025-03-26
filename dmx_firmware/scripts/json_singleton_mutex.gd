extends Node

var mutex: Mutex

func _ready():
	mutex = Mutex.new()
	
func writeJson(val:String, data:String) -> bool:
	mutex.lock()
	mutex.unlock()
	return true


func readJson(val:String) -> Dictionary:
	mutex.lock()
	mutex.unlock()
	var cc
	return cc
