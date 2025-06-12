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

func processDMXInput():
	var ligne = serial_port.read_line().strip_edges()
	if ligne == "":
		return
	buffer_trame += ligne
	var debut = buffer_trame.find("$")
	var fin = buffer_trame.find("#", debut)
	if debut != -1 and fin > debut:
		var trame = buffer_trame.substr(debut, fin - debut + 1)
		var checksum = buffer_trame.substr(fin + 1, buffer_trame.length() - fin - 1).strip_edges()
		buffer_trame = ""
		if verifTrame(trame, checksum):
			saveTrame(parseTrame(trame))
		else:
			print("❌ Erreur : Checksum incorrect ou trame invalide")

func verifTrame(trame, checksum_recu):
	if not trame.begins_with("$") or not trame.ends_with("#"):
		return false
	var contenu = trame.substr(1, trame.length() - 2)
	var valeurs = contenu.split(";")
	if valeurs.size() != 512:
		return false
	var somme = 0
	for v in valeurs:
		var val = int(v)
		if val >= 1 and val <= 255:
			somme += val
	var checksum_calc = somme % 255
	if checksum_calc != int(checksum_recu):
		print("❌ Checksum faux. Attendu :", checksum_calc, "Reçu :", checksum_recu)
		return false
	return true

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
