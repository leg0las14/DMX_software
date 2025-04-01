extends Node3D
class_name Sprite

var id:int

func _ready() -> void:
	print("new 3d model create")

func getPos()-> Vector3:
	return position

func getRotation() ->Vector3:
	return rotation

func setId(id_:int) ->void:
	id = id_

func getId() ->int:
	return id
