extends Node3D
@onready var singleton=Singleton
@onready var singleton_level = SingletonLevels

@onready var image =  $TextureRect


func _on_exploration_pressed():
	await get_tree().create_timer(0.25).timeout
	singleton_level.switch_to_scene("plain")
	self.queue_free()
	
	
func _on_experience_pressed():
	await get_tree().create_timer(0.25).timeout
#	singleton.switch_to_experience_scene()
	singleton.switch_to_scene("res://experience/gain.tscn")
	self.queue_free()
