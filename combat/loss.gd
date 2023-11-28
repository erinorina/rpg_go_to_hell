extends Node3D
@onready var singleton = Singleton
@onready var image = $TextureRect

func _ready():
	print("Loss -> life = 100")
	image.texture = load("res://storyboard/sleeping.png")
	singleton.reset_player_stats()

	await get_tree().create_timer(2).timeout
	singleton.switch_to_menu_scene()
	self.queue_free()

