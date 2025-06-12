extends Node3D

var env

func _ready():
	env = $"%WorldEnvironment"

	add_menu("res://menu/main_menu.tscn")
	print("new scene")

func add_menu(menu_path: String):
	var menu = load(menu_path).instantiate()
	menu.mainCamera = $"%CameraPivot"
	add_child(menu)

func changeFog(value: float):
	var environment :Environment = env.environment  # On accède à la ressource Environment
	environment.volumetric_fog_enabled = true
	environment.volumetric_fog_density = value  # Ici on affecte la valeur (avec =), pas avec des ()
