extends Spot

var arche
var pivot

func _ready() -> void:
	super()
	arche = $"%arche"
	pivot = $"%pivot tete"
	
func _process(delta: float) -> void:
	if arche:
		var target_y_degrees = dmx.getValue(0)
		var target_y_radians = deg_to_rad(target_y_degrees)
		var current_rot = arche.rotation
		current_rot.y = target_y_radians
		arche.rotation = current_rot

	if pivot:
		var target_x_degrees = dmx.getValue(1)
		var target_x_radians = deg_to_rad(target_x_degrees)
		var current_rota = pivot.rotation
		current_rota.x = target_x_radians
		pivot.rotation = current_rota
