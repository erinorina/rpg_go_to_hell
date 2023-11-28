extends Node3D
@onready var singleton = Singleton
@onready var image = $TextureRect

func _ready():
	print("Loss -> life = 100")
	image.texture = load("res://storyboard/sleeping.png")
	await get_tree().create_timer(2).timeout
	self.queue_free()

