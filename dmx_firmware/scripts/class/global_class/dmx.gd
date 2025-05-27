extends Node

var dmx_data: PackedByteArray

func _ready() -> void:
	dmx_data = PackedByteArray()
	dmx_data.resize(512)
	dmx_data.fill(0)

func getValue(pos: int) -> int:
	if pos <= 511 and pos >=0:
		return dmx_data[pos]
	else:
		return false

func setValue(val: int, pos:int)->void :
	if pos <= 511 and pos >=0:
		if val <=255 and val >=0:
			dmx_data[pos] = val
		else:
			print("valeur doit etre comprise entre 255 et 0")
	else:
		print("valeur doit être comprise entre 511 et 0")
