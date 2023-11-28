extends Node3D
@onready var singleton=Singleton
@onready var image =  $TextureRect

func _ready():
	singleton.switch_to_hud_scene()


func _on_reading_pressed():
	print("Reading a book")
	var reading_texture = load("res://storyboard/reading.png")
	image.texture = reading_texture
	singleton.player_stats["xp"] = max(singleton.player_stats["xp"] + 1, 0)
	print ("Book read, Exp +1")
	singleton.switch_to_exploration_plain()
	self.queue_free()

func _on_health_potion_pressed():
	singleton.player_stats["life"] = max(singleton.player_stats["life"] + 25, 0)
	singleton.switch_to_exploration_plain()
	self.queue_free()


func _on_attack_training_pressed():
	singleton.player_stats["attack"] = max(singleton.player_stats["attack"] + 1, 0)
	singleton.switch_to_exploration_plain()
	self.queue_free()

	
func _on_return_pressed():
	print("experience gain return -> menu")
	singleton.switch_to_menu_scene()
	self.queue_free()
