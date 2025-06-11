extends Entity
class_name Spot

@export var move_speed := 5.0
@export var acceleration := 10.0

var _velocity := Vector3.ZERO
var _input_dir := Vector3.ZERO

var id
var isSelect = false

var adresse:int
enum ecouleur {}
var couleur
var mode:String

func _ready() -> void:
	super()


func _process(delta: float) -> void:
	if isSelect:
		_input_dir = Vector3.ZERO
		
		if Input.is_action_pressed("move_forward"):
			_input_dir.z -= 1
		if Input.is_action_pressed("move_backward"):
			_input_dir.z += 1
		if Input.is_action_pressed("move_right"):
			_input_dir.x -= 1
		if Input.is_action_pressed("move_left"):
			_input_dir.x += 1

		_input_dir = _input_dir.normalized()
		var target_velocity = _input_dir * move_speed
		
		_velocity = _velocity.lerp(target_velocity, delta * acceleration)
		
		# Translation du node en local
		translate(_velocity * delta)


func setId(id_:int):
	id = id_

func unselect():
	isSelect = false

func select():
	isSelect = true
