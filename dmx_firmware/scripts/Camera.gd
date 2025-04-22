extends Node3D

class_name RtsCameraController

const RAY_DISTANCE: float = 100

@export var base_move_speed: float = 3  # Vitesse de base au zoom min
@export var camera_rotate_speed: float = 0.5
@export var camera_zoom_speed: float = 10

#@export var speedz: float = 10.0
@export var speedx: float = 2

@export var camera_zoom_steps: int = 5
@export var camera_zoom_min: float = 0.05
@export var camera_zoom_max: float = 10

@onready var camera = %MainCamera
@onready var camera_zoom_target: float = 0

var shift = false
var mouse_pressed = false
var last_mouse_pos_rotate: Vector2
var last_mouse_pos_move: Vector2

var start_position
var start_rotation

func _ready() -> void:
	start_position = global_position
	start_rotation = rotation_degrees
	

func _process(delta: float) -> void:
	_move(delta)
	_rotate(delta)
	_zoom(delta)
	_position()

func _move(delta: float) -> void:
	if mouse_pressed and shift:
		var mouse_delta = last_mouse_pos_move - get_viewport().get_mouse_position()
		var v = Vector3(mouse_delta.x, -mouse_delta.y, 0)

		if v.x != 0 or v.y != 0:
			# Calcul de la vitesse en fonction du zoom
			var zoom_factor = inverse_lerp(camera_zoom_min, camera_zoom_max, camera.position.z)
			var move_speed = lerp(base_move_speed * 0.5, base_move_speed * 2, zoom_factor)  # Vitesse plus lente zoomé, plus rapide dézoomé
			translate_object_local(v.normalized() * delta * move_speed)

	last_mouse_pos_move = get_viewport().get_mouse_position()
	
	#if Input.is_action_pressed("camera_move_forward"):  # Vérifie si "Z" est pressé
		#var forward = -transform.basis.z  # Obtient la direction avant de la caméra
		#position += forward * speedz * delta  # Déplace dans la direction avantz
	#if Input.is_action_pressed("camera_move_backward"):  # Vérifie si "Z" est pressé
		#var forward = transform.basis.z  # Obtient la direction avant de la caméra
		#position += forward * speedz * delta
	if Input.is_action_pressed("camera_move_right"):  # Vérifie si "Z" est pressé
		var forward = -transform.basis.x  # Obtient la direction avant de la caméra
		position += forward * speedx * delta
	if Input.is_action_pressed("camera_move_left"):  # Vérifie si "Z" est pressé
		var forward = +transform.basis.x  # Obtient la direction avant de la caméra
		position += forward * speedx * delta

func _rotate(delta: float) -> void:
	if mouse_pressed and !shift:
		var mouse_delta = last_mouse_pos_rotate - get_viewport().get_mouse_position()
		var v = Vector3(mouse_delta.y, mouse_delta.x, 0)
		if v.x != 0 or v.y != 0:
			rotate_object_local(v.normalized(), v.length() * delta * camera_rotate_speed)
		rotation.z = 0
	last_mouse_pos_rotate = get_viewport().get_mouse_position()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_MIDDLE and mouse_event.pressed:
			mouse_pressed = true
			last_mouse_pos_rotate = get_viewport().get_mouse_position()
			last_mouse_pos_move = get_viewport().get_mouse_position()
		elif mouse_event.button_index == MOUSE_BUTTON_MIDDLE and not mouse_event.pressed:
			mouse_pressed = false

	if event.is_action_pressed("shift"):
		shift = true
	elif event.is_action_released("shift"):
		shift = false
	if event.is_action_pressed("camera_zoom_in"):
		camera_zoom_target -= 1
	if event.is_action_pressed("camera_zoom_out"):
		camera_zoom_target += 1
	camera_zoom_target = clamp(camera_zoom_target, 0, camera_zoom_steps)


func _zoom(delta: float) -> void:
	var zoom_factor = camera_zoom_target / camera_zoom_steps
	zoom_factor = zoom_factor * zoom_factor * zoom_factor
	camera.position.z = lerp(camera.position.z, zoom_factor * camera_zoom_steps, 0.1)

func _position() -> void:
	if Input.is_action_pressed("camera_reset"):
		global_position = start_position
		rotation_degrees = start_rotation
		camera_zoom_target = 0

func raycast_from_camera() -> Dictionary:
	var space_state = get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	var rayOrigin = camera.project_ray_origin(mouse_position)
	var rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * RAY_DISTANCE
	var params = PhysicsRayQueryParameters3D.new()
	params.set(rayOrigin, rayEnd)
	return space_state.intersect_ray(params)
