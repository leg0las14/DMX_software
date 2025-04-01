extends Node3D
class_name Sprite


func _ready() -> void:
	print("new 3d model create")

func getPos()-> Vector3:
	return position

func getRotation() ->Vector3:
	return rotation
