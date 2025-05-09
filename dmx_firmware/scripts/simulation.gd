extends Node3D

var serial_port := SerialPort.new()

func _ready():
	add_menu("res://menu/main_menu.tscn")
	serial_port.port = "/dev/ttyUSB0"
	serial_port.baudrate = 115200
	serial_port.bytesize = 8
	serial_port.stopbits = 1

	if serial_port.open():
		print("✅ Port série ouvert avec succès.")
	else:
		print("❌ Échec de l'ouverture du port série.")

func add_menu(menu_path: String):
	var menu = load(menu_path).instantiate()
	menu.mainCamera = $"%CameraPivot"
	add_child(menu)
	
func _process(delta: float) -> void:
	if serial_port.is_open():
		var data = serial_port.read_line()  # Lit une ligne de données
		if data.length() > 0:
			print("📥 Données reçues : ", data)
