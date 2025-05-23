extends Node

var serial_port := SerialPort.new()
var buffer_trame := ""


func _ready() -> void:
	serial_port.port = "/dev/ttyUSB0"
	serial_port.baudrate = 115200
	serial_port.bytesize = SerialPort.BYTESIZE_8
	serial_port.stopbits = SerialPort.StopBits.STOPBITS_1 
	open_port()

func _process(_delta: float) -> void:
	if connectSerial():
		processDMXInput()

func connectSerial() -> bool:
	if not serial_port.is_open():
		serial_port.close()
		serial_port.open()
		return false
	return true

func processDMXInput() -> void:
	var chunk := serial_port.read_line().strip_edges()
	if chunk.is_empty():
		return
	buffer_trame += chunk
	var start := buffer_trame.find("$")
	var end := buffer_trame.find("#", start)
	if start != -1 and end > start:
		var trame := buffer_trame.substr(start, end - start + 1)
		buffer_trame = buffer_trame.substr(end + 1)
		if verifTrame(trame):
			saveTrame(parseTrame(trame))
		else:
			print("❌ Trame invalide")


func verifTrame(trame: String) -> bool:
	if not trame.begins_with("$") or not trame.ends_with("#"):
		return false

	var valeurs := parseTrame(trame)
	return valeurs.size() == 512

func saveTrame(data: PackedInt32Array):
	for i in range(data.size()):
		dmx.setValue(data[i], i)

func parseTrame(trame: String) -> PackedInt32Array:
	var contenu := trame.substr(1, trame.length() - 2)
	var valeurs_str := contenu.split(";")
	var valeurs := PackedInt32Array()

	for s in valeurs_str:
		valeurs.append(int(s))

	return valeurs

func get_port():
	return SerialPort.list_ports()

func open_port(port_ = serial_port.port):
	serial_port.port = port_
	if serial_port.open():
		print("❌ Échec de l'ouverture du port série.")
	else:
		print("✅ Port série ouvert avec succès.")

func close_port():
	serial_port.close()
