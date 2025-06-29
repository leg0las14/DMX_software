extends Spot

var arche
var pivot
var light

var is_init = false

var src_file

var name_ = ""

@export var pan_min := 0
@export var pan_max := 0
@export var tilt_min := 0
@export var tilt_max := 0

func _ready() -> void:
	super()
	arche = $"%arche"
	pivot = $"%pivot tete"
	light = $"%light"


func _process(_delta: float) -> void:
	actu()
	super._process(_delta)

func actu():
	if not is_init:
		return

	if arche:
		var raw_pan = dmx.getValue(0) # Pan : 0–255
		var mapped_pan = map(raw_pan, 0, 255, pan_min, pan_max)
		arche.rotation.y = deg_to_rad(mapped_pan)

	if pivot:
		var raw_tilt = dmx.getValue(2)
		var mapped_tilt = map(raw_tilt, 0, 255, tilt_min, tilt_max)
		pivot.rotation.x = deg_to_rad(mapped_tilt)

	if light:
		var intensity = float(dmx.getValue(5)) / 255.0
		var r = float(dmx.getValue(6)) / 255.0
		var g = float(dmx.getValue(7)) / 255.0
		var b = float(dmx.getValue(8)) / 255.0
		light.light_color = Color(r, g, b) * intensity
		light.light_energy = intensity * 10.0

func init(src):
	src_file = src
	var data = JsonSingletonMutex.readJson(src_file)

	if "spot" in data:
		name_ = data["spot"].get("name", "")
		if "movement" in data["spot"]:
			var move = data["spot"]["movement"]
			pan_max = move.get("pan_max", 0)
			pan_min = move.get("pan_min", 0)
			tilt_max = move.get("tilt_max", 0)
			tilt_min = move.get("tilt_min", 0)

	is_init = true

func map(x: int, in_min: int, in_max: int, out_min: float, out_max: float) -> float:
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if ModelManager.spotCanSelect():
		if event.is_action_pressed("left_mouse"):
			ModelManager.selectedElement(id)
