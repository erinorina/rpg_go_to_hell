extends Node3D
@onready var singleton=Singleton
@onready var image =  $TextureRect


func _on_exploration_pressed():
	await get_tree().create_timer(0.25).timeout
	singleton.switch_to_exploration_plain()
	self.queue_free()
	
	
func _on_experience_pressed():
	await get_tree().create_timer(0.25).timeout
	singleton.switch_to_experience_scene()
	self.queue_free()
